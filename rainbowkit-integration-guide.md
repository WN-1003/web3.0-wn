# RainbowKit 与 Hardhat 集成指南

## 一、RainbowKit 简介
RainbowKit 是一个用于简化 Web3 应用中钱包连接和管理的前端工具库，它提供了美观的钱包连接界面，支持多种钱包类型，并与 wagmi 和 ethers.js 无缝集成。

## 二、RainbowKit 与 Hardhat 的关系
- **Hardhat**: 用于智能合约的编译、测试和部署（后端）
- **RainbowKit**: 用于前端应用中的钱包连接和管理（前端）

它们可以在同一个项目中完美配合使用，Hardhat 负责智能合约开发，RainbowKit 负责前端与钱包的交互。

## 三、集成步骤

### 1. 添加前端框架
当前项目是一个纯 Hardhat 项目，需要先添加前端框架。我们以 React + Next.js 为例：

```shell
# 在项目根目录创建前端目录
mkdir frontend
cd frontend

# 初始化 Next.js 项目
npx create-next-app@latest . --typescript

# 安装依赖
npm install
```

### 2. 安装 RainbowKit 及其依赖
在 frontend 目录下：

```shell
# 安装 RainbowKit、wagmi 和 ethers
npm install @rainbow-me/rainbowkit wagmi ethers
```

### 3. 配置 RainbowKit

#### 3.1 修改布局文件

如果使用 Next.js 13+ App Router：

```typescript
// app/layout.tsx
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

// 导入 RainbowKit 和 wagmi
import '@rainbow-me/rainbowkit/styles.css'
import { getDefaultConfig, RainbowKitProvider } from '@rainbow-me/rainbowkit'
import { WagmiProvider } from 'wagmi'
import { sepolia, hardhat } from 'wagmi/chains'

const inter = Inter({ subsets: ['latin'] })

// 配置 wagmi
const config = getDefaultConfig({
  appName: 'Your DApp Name',
  projectId: 'YOUR_PROJECT_ID', // 需要在 WalletConnect 官网注册获取
  chains: [sepolia, hardhat],
  ssr: true, // Next.js 支持 SSR
})

export const metadata: Metadata = {
  title: 'Web3 DApp',
  description: 'Built with Next.js, RainbowKit and Hardhat',
}

export default function RootLayout({
  children,
}: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <WagmiProvider config={config}>
          <RainbowKitProvider>
            {children}
          </RainbowKitProvider>
        </WagmiProvider>
      </body>
    </html>
  )
}
```

#### 3.2 在页面中使用 RainbowKit

如果使用 Next.js 13+ App Router：

```typescript
// app/page.tsx
import { ConnectButton } from '@rainbow-me/rainbowkit'

export default function Home() {
  return (
    <main className="min-h-screen p-8">
      <h1 className="text-3xl font-bold mb-8">My DApp</h1>
      <ConnectButton />
    </main>
  )
}
```

### 4. 配置 WalletConnect Project ID
要使用 RainbowKit，需要在 [WalletConnect 官网](https://cloud.walletconnect.com/) 注册并获取 Project ID。

### 5. 与 Hardhat 集成

#### 5.1 编译智能合约
在项目根目录：
```shell
npx hardhat compile
```

#### 5.2 部署智能合约到本地网络
```shell
# 启动本地 Hardhat 节点
npx hardhat node

# 在另一个终端部署合约
npx hardhat ignition deploy ./ignition/modules/Lock.js --network localhost
```

#### 5.3 前端与智能合约交互
在前端代码中，可以使用 wagmi 和 ethers.js 与部署在本地或测试网的智能合约交互：

```javascript
import { useContractRead } from 'wagmi'
import { abi } from '../artifacts/contracts/Lock.sol/Lock.json'

function LockContract() {
  const { data: unlockTime } = useContractRead({
    address: '0x...', // 合约地址
    abi: abi,
    functionName: 'unlockTime',
  })

  return <div>Unlock time: {unlockTime}</div>
}
```

## 四、完整项目结构
```
├── frontend/           # 前端应用目录
│   ├── app/            # Next.js App Router 目录
│   │   ├── layout.tsx  # 布局文件
│   │   └── page.tsx    # 首页
│   ├── public/         # 静态资源
│   ├── package.json    # 前端依赖
│   ├── next.config.js  # Next.js 配置
│   └── ...
├── contracts/          # 智能合约文件
├── ignition/           # 部署配置
├── scripts/            # 部署脚本
├── test/               # 测试文件
├── hardhat.config.js   # Hardhat 配置
└── package.json        # 项目依赖
```

## 五、注意事项
1. 确保前端应用和 Hardhat 节点使用相同的网络配置
2. 在开发环境中，可以将 Hardhat 网络添加到 wagmi 配置中
3. 在生产环境中，建议只使用主网和测试网
4. 定期更新依赖包以确保安全性

## 六、参考资源
- [RainbowKit 官方文档](https://www.rainbowkit.com/docs/installation)
- [Wagmi 官方文档](https://wagmi.sh/)
- [Hardhat 官方文档](https://hardhat.org/docs)

通过以上步骤，您可以成功将 RainbowKit 与 Hardhat 集成，构建一个完整的 Web3 应用！