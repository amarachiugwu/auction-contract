// SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

interface IERC721 {
    function transferFrom (
        address from,
        address to,
        uint tokenId
    ) external;
} 

contract Auction {
    // IERC721 Interface
    // start auction by the seller
    // bid function
    // store failded bids
    // end auction by anybody
    // withdraw failed bids



    address payable public seller;
    address public nftAddr;
    uint public nftId;
    uint public minBid;
    uint public highestBid;
    address public highestBidder;
    bool public started;
    bool public ended;
    IERC721 public nft;
    uint32 deadline = uint32(block.timestamp + 180);

    mapping(address => uint) bids;

    event Start(address starter);
    event Bid (address bidder, uint amt);
    event End (address ender, address highestBidder, uint highestBid);
    event Withdraw(address addr, uint amt);

    constructor (
        uint _nftId,
        uint _minBid,
        address _nftAddr

    ) {
        seller = payable(msg.sender);
        nftId = _nftId;
        minBid = _minBid;
        nftAddr = _nftAddr;
    }

    function startAuction () external {
        require (!started, "auction started");
        require (msg.sender == seller, "not seller");

        started = true;

        nft = IERC721(nftAddr);
        nft.transferFrom(seller, address(this), nftId);

        emit Start (msg.sender);
    }

    function bid () payable external{
        require(started, "not started");
        require(block.timestamp < deadline, "Auction ended");
        require(msg.value >= minBid && msg.value > highestBid, "Bid not accepted");

        if(highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid (msg.sender, msg.value);
    }

    function endAuction () external{
        require(started, "not started");
        require(block.timestamp >= deadline, "time not reached");
        require(!ended, "Auction Ended");

        ended = true;
        
        nft = IERC721(nftAddr);
        if(highestBidder != address(0)){
            nft.transferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid); 
        }else{
            nft.transferFrom(address(this), seller, nftId);
        }


        emit End (msg.sender, highestBidder, highestBid);
    }

    function withdraw () external {
        uint balance = bids[msg.sender];
        require(balance > 0, "You have no bid");
        balance = 0;
        payable(msg.sender).transfer(balance);

        emit Withdraw (msg.sender, balance);
    }
}