const hre = require("hardhat");

async function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(() => resolve(), ms);
  });
}

async function main() {
  const initialAmount = hre.ethers.utils.parseEther("1");

  const Lottery = await hre.ethers.getContractFactory("Lottery");
  const contract = await Lottery.deploy({ value: initialAmount });

  await contract.deployed();
  console.log(`Lottery contract deployed to ${contract.address}`);

  await sleep(45 * 1000);
  await sleep(45 * 1000);

  await hre.run("verify:verify", {
    address: contract.address,
    constructorArguments: [],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});