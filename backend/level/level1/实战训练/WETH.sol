// WETH 是包装 ETH 主币，作为 ERC20 的合约。
// 标准的 ERC20 合约包括如下几个
// - 3 个查询
//   - balanceOf: 查询指定地址的 Token 数量
//   - allowance: 查询指定地址对另外一个地址的剩余授权额度
//   - totalSupply: 查询当前合约的 Token 总量
// - 2 个交易
//   - transfer: 从当前调用者地址发送指定数量的 Token 到指定地址。
//     - 这是一个写入方法，所以还会抛出一个 Transfer 事件。
//   - transferFrom: 当向另外一个合约地址存款时，对方合约必须调用 transferFrom 才可以把 Token 拿到它自己的合约中。
// - 2 个事件
//   - Transfer
//   - Approval
// - 1 个授权
//   - approve: 授权指定地址可以操作调用者的最大 Token 数量。
// ```
// SPDX-License-Identifier: MIT
// 指定 Solidity 编译器版本，要求版本大于等于 0.8.17 且小于 0.9.0
pragma solidity ^0.8.17;

/**
 * @title WETH 合约
 * @dev 该合约实现了 Wrapped Ether (WETH) 的功能，允许用户将 ETH 包装成 ERC20 标准的代币。
 */
contract WETH {
    // 代币名称
    string public name = "Wrapped Ether";
    // 代币符号
    string public symbol = "WETH";
    // 代币小数位数
    uint8 public decimals = 18;

    /**
     * @dev 当授权地址被允许从源地址转移一定数量代币时触发。
     * @param src 授权源地址。
     * @param delegateAds 被授权地址。
     * @param amount 授权的代币数量。
     */
    event Approval(address indexed src, address indexed delegateAds, uint256 amount);

    /**
     * @dev 当代币从一个地址转移到另一个地址时触发。
     * @param src 代币转出地址。
     * @param toAds 代币转入地址。
     * @param amount 转移的代币数量。
     */
    event Transfer(address indexed src, address indexed toAds, uint256 amount);

    /**
     * @dev 当用户向合约存入以太币并获得对应 WETH 时触发。
     * @param toAds 存入以太币的地址。
     * @param amount 存入的以太币数量。
     */
    event Deposit(address indexed toAds, uint256 amount);

    /**
     * @dev 当用户从合约提取 WETH 并换回以太币时触发。
     * @param src 提取 WETH 的地址。
     * @param amount 提取的 WETH 数量。
     */
    event Withdraw(address indexed src, uint256 amount);

    // 存储每个地址的代币余额
    mapping(address => uint256) public balanceOf;
    // 存储每个地址对其他地址的授权额度
    mapping(address => mapping(address => uint256)) public allowance;

    /**
     * @dev 允许用户将以太币存入合约，获得对应的 WETH 代币。
     * 存入的以太币数量会增加调用者的 WETH 余额，并触发 Deposit 事件。
     */
    function deposit() public payable {
        // 增加调用者的 WETH 余额
        balanceOf[msg.sender] += msg.value;
        // 触发 Deposit 事件
        emit Deposit(msg.sender, msg.value);
    }

    /**
     * @dev 允许用户从合约中提取 WETH 并换回以太币。
     * 提取前会检查用户的 WETH 余额是否足够，提取后会减少用户的 WETH 余额，并触发 Withdraw 事件。
     * @param amount 要提取的 WETH 数量。
     */
    function withdraw(uint256 amount) public {
        // 确保用户有足够的 WETH 余额
        require(balanceOf[msg.sender] >= amount);
        // 减少用户的 WETH 余额
        balanceOf[msg.sender] -= amount;
        // 将以太币发送回用户地址
        payable(msg.sender).transfer(amount);
        // 触发 Withdraw 事件
        emit Withdraw(msg.sender, amount);
    }

    /**
     * @dev 查询当前合约中 WETH 的总供应量，即合约持有的以太币总量。
     * @return uint256 合约持有的以太币总量。
     */
    function totalSupply() public view returns (uint256) {
        // 返回合约地址的以太币余额
        return address(this).balance;
    }

    /**
     * @dev 授权指定地址可以操作调用者的最大 Token 数量。
     * 授权后会更新授权记录，并触发 Approval 事件。
     * @param delegateAds 被授权的地址。
     * @param amount 被授权地址可以操作的最大 Token 数量。
     * @return bool 表示授权操作是否成功。
     */
    function approve(address delegateAds, uint256 amount) public returns (bool) {
        // 更新授权记录
        allowance[msg.sender][delegateAds] = amount;
        // 触发 Approval 事件
        emit Approval(msg.sender, delegateAds, amount);
        return true;
    }

    /**
     * @dev 从当前调用者地址发送指定数量的 Token 到指定地址。
     * 实际上调用了 transferFrom 函数，发送成功后会触发 Transfer 事件。
     * @param toAds 代币的目标地址。
     * @param amount 要转移的代币数量。
     * @return bool 表示转移是否成功。
     */
    function transfer(address toAds, uint256 amount) public returns (bool) {
        // 调用 transferFrom 函数进行转移
        return transferFrom(msg.sender, toAds, amount);
    }

    /**
     * @dev 从指定地址转移一定数量的代币到目标地址。
     * 转移前会检查源地址的余额和授权额度，转移后会更新余额和授权记录，并触发 Transfer 事件。
     * @param src 代币的源地址。
     * @param toAds 代币的目标地址。
     * @param amount 要转移的代币数量。
     * @return bool 表示转移是否成功。
     */
    function transferFrom(
        address src,
        address toAds,
        uint256 amount
    ) public returns (bool) {
        // 确保源地址有足够的余额
        require(balanceOf[src] >= amount);
        // 如果调用者不是源地址，需要检查授权额度
        if (src != msg.sender) {
            // 确保授权额度足够
            require(allowance[src][msg.sender] >= amount);
            // 扣除授权额度
            allowance[src][msg.sender] -= amount;
        }
        // 从源地址扣除余额
        balanceOf[src] -= amount;
        // 增加目标地址的余额
        balanceOf[toAds] += amount;
        // 触发 Transfer 事件
        emit Transfer(src, toAds, amount);
        return true;
    }

    /**
     * @dev 当合约收到未指定函数调用的以太币时，自动调用 deposit 函数。
     */
    fallback() external payable {
        // 调用 deposit 函数处理收到的以太币
        deposit();
    }

    /**
     * @dev 当合约通过普通转账方式收到以太币时，自动调用 deposit 函数。
     */
    receive() external payable {
        // 调用 deposit 函数处理收到的以太币
        deposit();
    }
}
