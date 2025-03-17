# web3.0-wn
web3学习

```shell
npx hardhat init   #初始化项目
npx hardhat compile #编译项目
npx hardhat test #测试项目

#启动本地节点
npx hardhat node
# Started HTTP and WebSocket JSON-RPC server at http://127.0.0.1:8545/

#部署项目
npx hardhat ignition deploy ./ignition/modules/Lock.js
#连接本地节点
npx hardhat ignition deploy ./ignition/modules/Lock.js --network localhost
# LockModule#Lock - 0x5FbDB2315678afecb367f032d93F642f64180aa3
```
