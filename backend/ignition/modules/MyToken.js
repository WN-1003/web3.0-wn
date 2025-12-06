const {buildModule} = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("MyTokenModulesV2", (m) => {
    // const initialSupply = m.getParameter("initialSupply", 200000);
    // const MyToken = m.contract("MyToken", [initialSupply]);
    const MyToken = m.contract("MyToken");
    return {MyToken};
})