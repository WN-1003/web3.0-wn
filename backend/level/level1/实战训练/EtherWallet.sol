// SPDX-License-Identifier: MIT
// 指定 Solidity 编译器版本，要求版本大于等于 0.8.17 且小于 0.9.0
pragma solidity ^0.8.17;

/**
 * @title EtherWallet 合约
 * @dev 该合约实现了一个简单的以太币钱包功能，允许所有者存入和提取以太币。
 */
contract EtherWallet {
    // 钱包所有者的地址，使用 immutable 修饰，确保在合约部署后地址不可变
    address payable public immutable owner;

    /**
     * @dev 日志事件，用于记录合约的操作信息。
     * @param funName 调用的函数名称。
     * @param from 操作发起的地址。
     * @param value 操作涉及的以太币数量。
     * @param data 操作附带的数据。
     */
    event Log(string funName, address from, uint256 value, bytes data);

    /**
     * @dev 合约构造函数，在合约部署时执行。
     * 初始化钱包所有者为合约部署者的地址。
     */
    constructor() {
        // 将合约部署者的地址赋值给 owner
        owner = payable(msg.sender);
    }

    /**
     * @dev 当合约通过普通转账方式收到以太币时，自动调用此函数。
     * 触发 Log 事件记录收款信息。
     */
    receive() external payable {
        // 触发 Log 事件，记录函数名、发送者地址、收到的以太币数量
        emit Log("receive", msg.sender, msg.value, "");
    }

    /**
     * @dev 从钱包中提取 100 单位的以太币到所有者地址。
     * 只有钱包所有者可以调用此函数。
     */
    function withdraw1() external {
        // 检查调用者是否为钱包所有者
        require(msg.sender == owner, "Not owner");
        // 注释说明 owner.transfer 相比 msg.sender 更消耗 Gas
        // owner.transfer(address(this).balance);
        // 将 100 单位的以太币转移到调用者地址
        payable(msg.sender).transfer(100);
    }

    /**
     * @dev 从钱包中尝试发送 200 单位的以太币到所有者地址。
     * 只有钱包所有者可以调用此函数。
     * 如果发送失败，交易会回滚。
     */
    function withdraw2() external {
        // 检查调用者是否为钱包所有者
        require(msg.sender == owner, "Not owner");
        // 尝试发送 200 单位的以太币到调用者地址
        bool success = payable(msg.sender).send(200);
        // 检查发送是否成功，如果失败则抛出错误
        require(success, "Send Failed");
    }

    /**
     * @dev 从钱包中尝试将所有以太币发送到所有者地址。
     * 只有钱包所有者可以调用此函数。
     * 如果发送失败，交易会回滚。
     */
    function withdraw3() external {
        // 检查调用者是否为钱包所有者
        require(msg.sender == owner, "Not owner");
        // 尝试将合约的所有以太币发送到调用者地址
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        // 检查发送是否成功，如果失败则抛出错误
        require(success, "Call Failed");
    }

    /**
     * @dev 查询当前钱包合约的以太币余额。
     * @return uint256 合约持有的以太币余额。
     */
    function getBalance() external view returns (uint256) {
        // 返回合约地址的以太币余额
        return address(this).balance;
    }
}