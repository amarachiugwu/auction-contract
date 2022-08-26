import { ethers } from "hardhat";

async function main() {
    const Auction = await ethers.getContractFactory("Auction");
    const auction = Auction.attach("0x5EA284f793fB4a158cF4D7AA56be3D955bf56959");

    const AmaraNFT = await ethers.getContractFactory("AmaraNFT");
    const amaraNFT = AmaraNFT.attach("0x635e64E62EC1789b5E5a1Dda3e68b772241cDc05");

    // const approveTnx = await amaraNFT.approve("0x5EA284f793fB4a158cF4D7AA56be3D955bf56959", 0);
    // const approveTnxReceipt = await approveTnx.wait();

    // console.log("Approve tnx: ", approveTnxReceipt);



    const started = await auction.started();
    console.log(`started before calling startAuction : ${started}`);

    // const startAuction = await auction.startAuction();
    // const startAuctionReceipt = await startAuction.wait();

    // console.log(`startAuction Reciept : ${startAuctionReceipt}`);

    // const started1 = await auction.started();
    // console.log(`started after calling startAuction : ${started1}`);
}

main()
.catch((error) => {
    console.error(error);
    process.exitCode = 1;
});