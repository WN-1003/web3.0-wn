// SPDX-License-Identifier: MIT
// 指定 Solidity 版本，要求编译器版本大于等于 0.8.24 且小于 0.9.0
pragma solidity ^0.8.24;

/**
 * @title Counter
 * @dev 一个简单的计数器合约，提供计数的获取、增加和减少功能。
 */
contract Counter {
    // 公开的无符号整数变量，用于存储计数器的值
    uint256 public count;

    /**
     * @dev 获取当前计数器的值。
     * @return uint256 当前计数器的值。
     */
    function get() public view returns (uint256) {
        return count;
    }

    /**
     * @dev 将计数器的值加 1。
     */
    function inc() public {
        count += 1;
    }

    /**
     * @dev 将计数器的值减 1。
     * @notice 如果计数器的值为 0，此函数将失败。
     */
    function dec() public {
        // 当 count 为 0 时，此函数会失败
        count -= 1;
    }
}