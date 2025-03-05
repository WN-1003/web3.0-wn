
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
    
}