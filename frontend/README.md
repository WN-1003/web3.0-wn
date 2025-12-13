# web3.0-wn Frontend
Web3.0 DApp 前端应用

## 项目介绍
这是 web3.0-wn 项目的前端部分，基于 Next.js 16 和 React 19 构建的 Web3 DApp 应用。该应用用于与后端智能合约交互，提供用户友好的界面来体验和测试智能合约功能。

## 技术栈
- **Next.js 16**: React 框架，支持服务器端渲染
- **React 19**: UI 组件库
- **TypeScript**: 类型安全的 JavaScript
- **Tailwind CSS 4**: 样式框架
- **RainbowKit**: Web3 钱包连接工具（可集成，参考根目录 rainbowkit-integration-guide.md）
- **Wagmi**: Web3 React Hooks 库（可集成）
- **Ethers.js**: 以太坊 JavaScript API（可集成）

## 项目结构
```
├── public/          # 静态资源
├── src/
│   ├── app/         # Next.js App Router 目录
│   │   ├── layout.tsx  # 应用布局
│   │   ├── page.tsx    # 首页
│   │   └── globals.css # 全局样式
├── .gitignore
├── eslint.config.mjs
├── next.config.ts
├── package-lock.json
├── package.json
├── postcss.config.mjs
└── tsconfig.json
```

## 安装和设置

### 1. 安装依赖
```shell
npm install
```

### 2. 开发服务器
```shell
npm run dev
```

应用将在 `http://localhost:3000` 启动。

### 3. 构建生产版本
```shell
npm run build
npm start
```

### 4. 代码检查
```shell
npm run lint
```

## 与智能合约交互
要与后端智能合约交互，您可以：

1. 查看根目录下的 `rainbowkit-integration-guide.md` 文档，了解如何集成 RainbowKit 钱包连接

2. 使用 wagmi 和 ethers.js 与智能合约交互：
```typescript
import { useContractRead } from 'wagmi'
import { abi } from '../../backend/artifacts/contracts/Lock.sol/Lock.json'

function LockContract() {
  const { data: unlockTime } = useContractRead({
    address: '0x...', // 合约地址
    abi: abi,
    functionName: 'unlockTime',
  })

  return <div>Unlock time: {unlockTime}</div>
}
```

## 钱包集成
项目支持通过 RainbowKit 集成多种 Web3 钱包，包括：
- MetaMask
- Coinbase Wallet
- WalletConnect
- Ledger
- 等多种流行钱包

详细集成步骤请参考根目录下的 `rainbowkit-integration-guide.md`。

## 注意事项
1. 确保与后端智能合约使用相同的网络配置
2. 在开发环境中，需要启动本地 Hardhat 节点
3. 测试网或主网部署需要配置相应的网络参数
4. 保护好私钥和敏感信息，不要提交到版本控制系统

## 学习资源
- [Next.js Documentation](https://nextjs.org/docs) - Next.js 官方文档
- [React Documentation](https://react.dev/) - React 官方文档
- [Tailwind CSS Documentation](https://tailwindcss.com/docs) - Tailwind CSS 官方文档
- [RainbowKit Documentation](https://www.rainbowkit.com/docs) - RainbowKit 官方文档
- [Wagmi Documentation](https://wagmi.sh/) - Wagmi 官方文档

## 许可证
MIT License