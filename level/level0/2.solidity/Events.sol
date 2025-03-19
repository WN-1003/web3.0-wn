// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Events允许记录到以太坊区块链。事件的一些用例如下：
// 监听事件并更新用户界面
// 一种廉价的存储方式
contract Event {
    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters helps you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}