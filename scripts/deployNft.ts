import { ethers } from "hardhat";

async function main() {

  const deployNft = await ethers.deployContract("OnChainNFT");

  await deployNft.waitForDeployment();

  console.log(
    `deployNftContract contract successfully deployed to: ${deployNft.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});