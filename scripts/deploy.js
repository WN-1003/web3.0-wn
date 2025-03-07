async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const Demo = await ethers.getContractFactory("Demo");
  const demo = await Demo.deploy();

  console.log("Demo contract address:", demo.address);
}

main()
 .then(() => process.exit(0))
 .catch((error) => {
    console.error(error);
    process.exit(1);
  });
