

const hre = require("hardhat");
const {expect} = require("chai");

describe("MyToken Test", async() => {
    const { ethers } = hre;
    const initialSupply = 10000;
    let MyTokenContract;
    let account1, account2;

    beforeEach(async () => {
        [account1, account2] = await ethers.getSigners();
        console.log("account1:", account1.address);
        console.log("account2:", account2.address);

        const MyToken = await ethers.getContractFactory("MyToken");
        // MyTokenContract = await MyToken.deploy(initialSupply);  // 默认使用account1
        MyTokenContract = await MyToken.connect(account2).deploy(initialSupply);
        MyTokenContract.waitForDeployment();
        const contractAddress = await MyTokenContract.getAddress();

        expect(contractAddress).to.length.greaterThan(0);
        console.log("contractAddress:", contractAddress);
    });

    it("验证合约的 name、symbol、decimals", async () => { 
        console.log("I am test1");
        const name = await MyTokenContract.name();
        const symbol = await MyTokenContract.symbol();
        const decimals = await MyTokenContract.decimals();

        expect(name).to.equal("MyToken");
        expect(symbol).to.equal("MTK");
        expect(decimals).to.equal(18);
    });

    it("测试转账", async () => {
        // 执行转账
        const resp = await MyTokenContract.transfer(account1, initialSupply / 2);
        console.log(resp);

        // 验证转账成功
        const  balanceOfAccount2 = await MyTokenContract.balanceOf(account2);
        expect(balanceOfAccount2).to.equal(initialSupply / 2);
    });
});