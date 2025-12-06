// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // constructor(uint256 initialSupply) ERC20("MyToken", "WNBTC") {
    //     _mint(msg.sender, initialSupply);
    // }
    constructor() ERC20("MyToken", "WNBTC") {
        _mint(msg.sender, 200000*10**18);
    }
}