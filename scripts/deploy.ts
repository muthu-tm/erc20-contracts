// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // Total Supply = 3M
  const totalSupply = 300000000000;

  // We get the contract to deploy
  const MGTToken = await ethers.getContractFactory("MyGeekToken");

  // Replace 0x with valid address before trigger the deploy script
  const token = await MGTToken.deploy(totalSupply, "0x", "0x");

  await token.deployed();

  console.log("MyGeek Token (MGT) deployed to: ", token.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
