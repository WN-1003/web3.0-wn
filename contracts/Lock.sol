// SPDX-License-Identifier: UNLICENSED
// 指定该合约使用的 SPDX 许可证标识符为未授权
pragma solidity ^0.8.28;
// 声明使用的 Solidity 版本，要求版本大于等于 0.8.28 且小于 0.9.0

// Uncomment this line to use console.log
// 如果需要在终端打印日志，取消注释下面这行代码
import "hardhat/console.sol";

// 一个简单的锁定合约，用于在指定时间后提取资金
contract Lock {
    // 存储解锁时间的变量，使用 public 修饰符可以自动生成 getter 函数
    uint public unlockTime;
    // 存储合约所有者的地址，使用 payable 修饰符表示该地址可以接收以太币
    address payable public owner;

    /**
     * @dev 当资金从合约中提取时触发的事件
     * @param amount 提取的金额
     * @param when 提取的时间戳
     */
    event Withdrawal(uint amount, uint when);

    /**
     * @dev 合约构造函数，在合约部署时执行
     * @param _unlockTime 合约解锁的时间戳
     */
    constructor(uint _unlockTime) payable {
        // 检查解锁时间是否在未来，如果不是则抛出错误
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        // 将传入的解锁时间赋值给合约的 unlockTime 变量
        unlockTime = _unlockTime;
        // 将合约部署者的地址赋值给合约的 owner 变量
        owner = payable(msg.sender);
    }

    /**
     * @dev 从合约中提取资金的函数
     */
    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // 如果需要在终端打印日志，取消注释下面这行代码和上面的 import 语句
        console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        // 检查当前时间是否已经超过解锁时间，如果没有则抛出错误
        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        // 检查调用者是否为合约所有者，如果不是则抛出错误
        require(msg.sender == owner, "You aren't the owner");

        // 触发 Withdrawal 事件，记录提取的金额和时间
        emit Withdrawal(address(this).balance, block.timestamp);

        // 将合约的全部余额转移给合约所有者
        owner.transfer(address(this).balance);
    }
}
