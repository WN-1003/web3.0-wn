# web3.0-wn
Web3.0智能合约开发学习项目

## 项目介绍
这是一个完整的Web3.0学习项目，包含后端智能合约开发和前端DApp应用，旨在帮助开发者学习和实践Web3.0技术栈。项目提供了丰富的示例代码、学习资源和实战训练，适合从基础到进阶的Web3.0开发学习。

## 技术栈

### 后端（智能合约）
- **Solidity**: 智能合约开发语言
- **Hardhat**: 以太坊开发环境和框架
- **OpenZeppelin Contracts**: 开源智能合约库
- **Ethers.js**: 以太坊JavaScript API
- **Web3.js**: 以太坊JavaScript API
- **Chai**: 测试框架

### 前端（DApp）
- **Next.js 16**: React框架
- **React 19**: UI组件库
- **TypeScript**: 类型安全的JavaScript
- **Tailwind CSS 4**: 样式框架

## 项目结构
```
├── backend/           # 智能合约开发
│   ├── contracts/     # 智能合约文件
│   ├── scripts/       # 部署脚本
│   ├── test/          # 测试文件
│   ├── level/         # 学习资源和作业
│   └── hardhat.config.js
├── frontend/          # DApp前端
│   ├── src/app/       # Next.js应用代码
│   ├── public/        # 静态资源
│   └── next.config.ts
├── rainbowkit-integration-guide.md  # RainbowKit集成指南
└── README.md          # 项目文档
```

## 安装和设置

### 1. 后端设置

#### 安装依赖
```shell
cd backend
npm install
```

#### 配置环境变量
在`backend/`目录创建`.env`文件：
```
INFURA_API_KEY=your_infura_api_key
PRIVATE_KEY=your_wallet_private_key
```

### 2. 前端设置

#### 安装依赖
```shell
cd frontend
npm install
```

## 快速开始

### 后端开发流程

#### 编译合约
```shell
cd backend
npx hardhat compile
```

#### 运行测试
```shell
cd backend
npx hardhat test
```

#### 启动本地节点
```shell
cd backend
npx hardhat node
```

#### 部署合约
```shell
# 部署到本地节点
cd backend
npx hardhat ignition deploy ./ignition/modules/Lock.js --network localhost

# 部署到Sepolia测试网
npx hardhat ignition deploy ./ignition/modules/Lock.js --network sepolia
```

### 前端开发流程

#### 启动开发服务器
```shell
cd frontend
npm run dev
```

#### 构建生产版本
```shell
cd frontend
npm run build
npm start
```

## 核心功能

### 智能合约示例

#### Lock.sol
- 简单的资金锁定合约
- 支持指定时间后提取资金
- 只有所有者可以提取

#### MyToken.sol
- 基于OpenZeppelin的ERC20代币合约
- 标准ERC20功能（转账、批准、余额查询等）
- 可配置的代币参数

#### ERC20MinerReward.sol
- 挖矿奖励机制的ERC20代币
- 支持挖矿奖励分发

### 学习资源
项目包含分级学习资源：

#### Level 0: 基础入门
- 区块链概念
- 以太坊基础知识
- Solidity语法基础
- 加密钱包使用

#### Level 1: 进阶学习
- 以太坊原理
- 共识机制
- 合约安全与攻击防护
- Web3.js集成
- 实战项目（Bank、CrowdFunding、MultiSigWallet等）

#### Level 2: 高级应用
- DApp架构设计
- 合约升级技术
- 高级数据结构使用

## RainbowKit钱包集成
项目提供了RainbowKit钱包集成指南，帮助开发者快速实现Web3钱包连接功能。

## 注意事项
1. 不要在生产环境中使用测试网络的配置
2. 保护好你的私钥，不要提交到版本控制系统
3. 定期更新依赖包以确保安全性
4. 在部署到主网前充分测试合约功能

## 许可证
MIT License