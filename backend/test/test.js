const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Demo", function () {
  let demo;

  beforeEach(async function () {
    const Demo = await ethers.getContractFactory("Demo");
    // 移除对 deployed() 方法的调用
    demo = await Demo.deploy();
    // 不再需要 await demo.deployed();
  });

  it("Should calculate square correctly", async function () {
    const result = await demo.square(5);
    expect(result).to.equal(25);
  });

  it("Should calculate double correctly", async function () {
    const result = await demo.double(5);
    expect(result).to.equal(10);
  });

  it("Should get square selector correctly", async function () {
    const selector = await demo.getSquareSelect();
    expect(selector).to.equal(demo.square.selector);
  });

  it("Should get double selector correctly", async function () {
    const selector = await demo.getDoubleSelect();
    expect(selector).to.equal(ethers.utils.id("double(uint256)").slice(0, 10));
  });

  it("Should execute function correctly", async function () {
    const squareSelector = await demo.getSquareSelect();
    const tx = await demo.executeFunction(squareSelector, 5);
    const receipt = await tx.wait();
    const result = receipt.events?.find(e => e.event === 'FunctionExecuted')?.args?.result;
    expect(result).to.equal(25);
  });

  it("Should store and execute stored function correctly", async function () {
    const squareSelector = await demo.getSquareSelect();
    await demo.storeSelector(squareSelector);
    const tx = await demo.executeStoredFunction(5);
    const receipt = await tx.wait();
    const result = receipt.events?.find(e => e.event === 'FunctionExecuted')?.args?.result;
    expect(result).to.equal(25);
  });
});
