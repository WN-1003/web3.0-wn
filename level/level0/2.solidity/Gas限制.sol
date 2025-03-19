// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 你可以花费的 gas 量有两个上限
// gas limit（您愿意在交易中使用的最大 gas 量由您设置）
// block gas limit（区块中允许的最大 gas 量由网络设置）
contract Gas {
    uint256 public i = 0;

    // 消耗掉你发送的所有Gas会导致你的交易失败。
    // 状态变更将被撤销。
    // 已消耗的Gas不会被退还。
    function forever() public {
        // 这里我们运行一个循环，直到所有的Gas被消耗完
        // 然后交易失败
        while (true) {
            i += 1;
        }
    }
}