import { ethers } from "hardhat";

async function main() {
  const Auction = await ethers.getContractFactory("Auction");
  const auction = await Auction.deploy(0, ethers.utils.parseEther("0.5"), "0x635e64E62EC1789b5E5a1Dda3e68b772241cDc05");

  await auction.deployed();

  console.log(`Auction contract deployed at : ${auction.address}`)

  // deployed contract rinkeby address : 0x5EA284f793fB4a158cF4D7AA56be3D955bf56959
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
