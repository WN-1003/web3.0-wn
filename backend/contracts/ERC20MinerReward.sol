// SPDX-License-Identifier: MIT 
// 指定合约使用的许可证为MIT

pragma solidity >=0.4.22;
// 声明合约所使用的Solidity编译器版本，要求版本大于等于0.4.22

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
// 导入OpenZeppelin库中的ERC20合约，用于实现ERC20代币标准

/**
 * @title ERC20MinerReward
 * @dev 该合约继承自ERC20合约，用于向矿工奖励代币。
 */
contract ERC20MinerReward is ERC20 { 
    // 定义一个事件，用于记录新的警报信息
    event LogNewAlert(string description, address indexed _from, uint256 _n);

    // 合约的构造函数，初始化ERC20代币的名称和符号。代币名称为 "MinerReward"，符号为 "MRW"。
    constructor() ERC20("MinerReward", "MRW") {} 

    // 此函数用于向矿工奖励代币。 它会铸造20个代币到当前区块的矿工地址，并发出一个日志事件。
    function _reward() public { 
        // 调用ERC20合约的内部函数 _mint，铸造20个代币到当前区块的矿工地址
        _mint(block.coinbase, 20); 
        // 发出一个日志事件，记录奖励信息，包括描述、矿工地址和当前区块号
        emit LogNewAlert('_rewarded', block.coinbase, block.number); 
    } 
} 