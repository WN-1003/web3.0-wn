// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SimpleStorage {
    // 用于存储一个数字的状态变量
    uint256 public num;

    // 你需要发送一笔交易来写入状态变量。
    function set(uint256 _num) public {
        num = _num;
    }

    // 你可以在不发送交易的情况下读取状态变量。可以免费读取状态变量，无需支付任何交易费。
    function get() public view returns (uint256) {
        return num;
    }
}