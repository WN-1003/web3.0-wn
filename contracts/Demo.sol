
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Demo {
    // 函数：计算平方
    function square(uint256 x) public pure returns (uint256) {
        return x * x;
    }
    // 函数：计算两倍
    function double (uint256 x) public pure returns (uint256) {
        return x * 2;
    }
    // 函数：返回函数的选择器selector
    function getSquareSelect() public pure returns (bytes4) {
        return this.square.selector;
    }
    function getDoubleSelect() public pure returns (bytes4) {
        return bytes4(keccak256("double(uint256)"));
    }
    // 函数：根据传入的选择器动态调用 square 或 double 函数
    function executeFunction(bytes4 selector, uint256 x) public returns (uint256 z) {
        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(selector, x));
        require(success, "Function call failed");
        z = abi.decode(data, (uint256));
    }


    // 状态变量，用于存储函数选择器
    bytes4 storedSelector;

    // 函数：将选择器存储在状态变量 storedSelector 中
    function storeSelector(bytes4 selector) public {
        storedSelector = selector;
    }

    // 函数：调用存储在 storedSelector 中的函数，并返回结果
    function executeStoredFunction(uint256 x) public returns (uint256 z) {
        require(storedSelector != bytes4(0), "No function stored");
        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(storedSelector, x));
        require(success, "Function call failed");
        z = abi.decode(data, (uint256));
    }
}