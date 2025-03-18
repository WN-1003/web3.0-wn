// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// 构造函数是在创建合约时执行的可选函数。
// 下面是如何向构造函数传递参数的示例。
// 基合约 X
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// 基合约 Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 有两种方式可以用参数初始化父合约。

// 在这里的继承列表中传递参数。
contract B is X("Input to X"), Y("Input to Y") {}

contract C is X, Y {
    // 在这里的构造函数中传递参数，
    // 类似于函数修饰符。
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// 无论子合约的构造函数中列出的父合约顺序如何，
// 父合约的构造函数总是按照继承顺序被调用。

// 构造函数调用顺序:
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}

// 构造函数调用顺序:
// 1. X
// 2. Y
// 3. E
contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}