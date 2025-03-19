// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract IfElse {
    function foo(uint256 x) public pure returns (uint256) {
        if (x < 10) {
            return 0;
        } else if (x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint256 _x) public pure returns (uint256) {
        // 如果 (_x < 10) {
        //     返回 1;
        // }
        // 返回 2;

        // 编写 if / else 语句的简写方式
        // "?" 运算符被称为三元运算符
        return _x < 10 ? 1 : 2;
    }
}