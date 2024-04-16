const hre = require("hardhat");

async function main() {
  // Deploy the Lottery contract
  const Lottery = await hre.ethers.getContractFactory("Lottery");
  const [deployer] = await hre.ethers.getSigners();
  const contract = await Lottery.deploy();

  console.log("Lottery contract deployed to:", contract.address);

  // Wait for the contract to be deployed
  await contract.deployTransaction.wait();

  // Verify the contract on Etherscan
  await hre.run("verify:verify", {
    address: contract.address,
    constructorArguments: [],
  });

  console.log("Lottery contract verified on Etherscan!");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});