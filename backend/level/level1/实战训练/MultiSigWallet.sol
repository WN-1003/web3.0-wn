// SPDX-License-Identifier: MIT
// 指定Solidity版本，支持0.8.17及以上，但不包括0.9.0
pragma solidity ^0.8.17;

/**
 * @title MultiSigWallet
 * @dev 一个多重签名钱包合约，需要多个所有者的批准才能执行交易。
 */
contract MultiSigWallet {
    // 状态变量
    /**
     * @dev 存储所有钱包所有者的地址数组。
     */
    address[] public owners;
    /**
     * @dev 映射，用于快速检查某个地址是否为钱包所有者。
     */
    mapping(address => bool) public isOwner;
    /**
     * @dev 执行交易所需的最少批准数。
     */
    uint256 public required;

    /**
     * @dev 定义交易结构体，包含交易的目标地址、价值、数据和执行状态。
     */
    struct Transaction {
        // 交易的目标地址
        address to;
        // 交易的价值（以太币数量）
        uint256 value;
        // 交易的数据
        bytes data;
        // 交易是否已执行
        bool exected;
    }

    /**
     * @dev 存储所有待处理和已执行的交易数组。
     */
    Transaction[] public transactions;
    /**
     * @dev 二维映射，记录每个所有者对每笔交易的批准状态。
     */
    mapping(uint256 => mapping(address => bool)) public approved;

    // 事件
    /**
     * @dev 当有以太币存入钱包时触发该事件。
     * @param sender 存入以太币的地址。
     * @param amount 存入的以太币数量。
     */
    event Deposit(address indexed sender, uint256 amount);
    /**
     * @dev 当提交一笔新交易时触发该事件。
     * @param txId 新交易的ID。
     */
    event Submit(uint256 indexed txId);
    /**
     * @dev 当所有者批准一笔交易时触发该事件。
     * @param owner 批准交易的所有者地址。
     * @param txId 被批准的交易ID。
     */
    event Approve(address indexed owner, uint256 indexed txId);
    /**
     * @dev 当所有者撤销对一笔交易的批准时触发该事件。
     * @param owner 撤销批准的所有者地址。
     * @param txId 被撤销批准的交易ID。
     */
    event Revoke(address indexed owner, uint256 indexed txId);
    /**
     * @dev 当一笔交易被执行时触发该事件。
     * @param txId 被执行的交易ID。
     */
    event Execute(uint256 indexed txId);

    /**
     * @dev 当合约收到以太币时，自动触发Deposit事件。
     */
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 函数修改器
    /**
     * @dev 确保只有钱包所有者才能调用被修饰的函数。
     */
    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    /**
     * @dev 确保指定的交易ID存在。
     * @param _txId 要检查的交易ID。
     */
    modifier txExists(uint256 _txId) {
        require(_txId < transactions.length, "tx doesn't exist");
        _;
    }

    /**
     * @dev 确保调用者尚未批准指定的交易。
     * @param _txId 要检查的交易ID。
     */
    modifier notApproved(uint256 _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    /**
     * @dev 确保指定的交易尚未执行。
     * @param _txId 要检查的交易ID。
     */
    modifier notExecuted(uint256 _txId) {
        require(!transactions[_txId].exected, "tx is exected");
        _;
    }

    /**
     * @dev 合约构造函数，初始化钱包所有者和所需批准数。
     * @param _owners 钱包所有者的地址数组。
     * @param _required 执行交易所需的最少批准数。
     */
    constructor(address[] memory _owners, uint256 _required) {
        require(_owners.length > 0, "owner required");
        require(
            _required > 0 && _required <= _owners.length,
            "invalid required number of owners"
        );
        for (uint256 index = 0; index < _owners.length; index++) {
            address owner = _owners[index];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique"); // 如果重复会抛出错误
            isOwner[owner] = true;
            owners.push(owner);
        }
        required = _required;
    }

    /**
     * @dev 获取钱包的当前以太币余额。
     * @return 钱包的当前以太币余额。
     */
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev 提交一笔新的交易。
     * @param _to 交易的目标地址。
     * @param _value 交易的价值（以太币数量）。
     * @param _data 交易的数据。
     * @return 新交易的ID。
     */
    function submit(
        address _to,
        uint256 _value,
        bytes calldata _data
    ) external onlyOwner returns(uint256){
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, exected: false})
        );
        emit Submit(transactions.length - 1);
        return transactions.length - 1;
    }

    /**
     * @dev 所有者批准一笔交易。
     * @param _txId 要批准的交易ID。
     */
    function approv(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notApproved(_txId)
        notExecuted(_txId)
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    /**
     * @dev 执行一笔已批准的交易。
     * @param _txId 要执行的交易ID。
     */
    function execute(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notExecuted(_txId)
    {
        require(getApprovalCount(_txId) >= required, "approvals < required");
        Transaction storage transaction = transactions[_txId];
        transaction.exected = true;
        (bool sucess, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(sucess, "tx failed");
        emit Execute(_txId);
    }

    /**
     * @dev 获取指定交易的批准数量。
     * @param _txId 要检查的交易ID。
     */
    function getApprovalCount(uint256 _txId)
        public
        view
        returns (uint256 count)
    {
        for (uint256 index = 0; index < owners.length; index++) {
            if (approved[_txId][owners[index]]) {
                count += 1;
            }
        }
    }

    /**
     * @dev 所有者撤销对一笔交易的批准。
     * @param _txId 要撤销批准的交易ID。
     */
    function revoke(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notExecuted(_txId)
    {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}