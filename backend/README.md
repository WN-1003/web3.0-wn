# web3.0-wn
Web3.0智能合约开发学习项目

## 项目介绍
这是一个基于Hardhat的Solidity智能合约开发学习项目，包含了多个示例合约和学习资源，用于Web3.0技术的学习和实践。

## 技术栈
- **Solidity**: 智能合约开发语言
- **Hardhat**: 以太坊开发环境和框架
- **OpenZeppelin Contracts**: 开源智能合约库
- **Ethers.js**: 以太坊JavaScript API
- **Web3.js**: 以太坊JavaScript API
- **Chai**: 测试框架

## 安装和设置

### 1. 安装依赖
```shell
npm install
```

### 2. 配置环境变量
创建`.env`文件并添加以下内容：
```
INFURA_API_KEY=your_infura_api_key
PRIVATE_KEY=your_wallet_private_key
```

## 项目结构
```
├── contracts/          # 智能合约文件
│   ├── Lock.sol       # 简单锁定合约示例
│   ├── MyToken.sol    # ERC20代币合约
│   ├── Demo.sol       # 演示合约
│   └── ERC20MinerReward.sol # 挖矿奖励代币合约
├── scripts/           # 部署脚本
├── test/              # 测试文件
├── ignition/          # 部署配置
├── level/             # 学习资源和作业
├── hardhat.config.js  # Hardhat配置
└── package.json       # 项目依赖
```

## 合约功能介绍

### Lock.sol
一个简单的锁定合约，允许在指定时间后提取资金：
- 部署时设置解锁时间
- 只有合约所有者可以提取资金
- 提取前必须达到解锁时间

### MyToken.sol
基于OpenZeppelin的ERC20代币合约：
- 标准ERC20功能
- 可配置的名称、符号和小数位数
- 支持转账、批准等操作

### ERC20MinerReward.sol
挖矿奖励代币合约：
- 基于ERC20标准
- 包含挖矿奖励机制

## 常用命令

### 编译合约
```shell
npx hardhat compile
```

### 运行测试
```shell
npx hardhat test
```

### 启动本地节点
```shell
npx hardhat node
# Started HTTP and WebSocket JSON-RPC server at http://127.0.0.1:8545/
```

### 部署合约

#### 部署到Hardhat内置网络
```shell
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

#### 部署到本地节点
```shell
npx hardhat ignition deploy ./ignition/modules/Lock.js --network localhost
```

#### 部署到Sepolia测试网
```shell
npx hardhat ignition deploy ./ignition/modules/Lock.js --network sepolia
```

#### 部署到以太坊主网
```shell
npx hardhat ignition deploy ./ignition/modules/Lock.js --network mainnet
```

### 查看账户信息
```shell
npx hardhat accounts
```

## 学习资源
项目包含了各级别的学习资源，位于`level/`目录：
- **level0**: 区块链基础知识、以太坊概念、加密钱包使用
- **level1**: 以太坊原理、共识机制、合约安全、Web3.js使用
- **level2**: Dapp架构设计

## 注意事项
1. 确保在部署到测试网或主网前，你的钱包有足够的测试币或以太币
2. 不要在生产环境中使用默认的私钥和配置
3. 定期更新依赖包以确保安全性

## 许可证
MIT License
