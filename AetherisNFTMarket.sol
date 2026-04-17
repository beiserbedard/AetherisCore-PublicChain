// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisNFTMarket {
    struct Listing {
        address seller;
        uint256 price;
        bool active;
    }

    mapping(address => mapping(uint256 => Listing)) public listings;
    event Listed(address indexed nft, uint256 tokenId, uint256 price);
    event Sold(address indexed nft, uint256 tokenId, address buyer);

    function listNFT(address nft, uint256 tokenId, uint256 price) external {
        listings[nft][tokenId] = Listing({
            seller: msg.sender,
            price: price,
            active: true
        });
        emit Listed(nft, tokenId, price);
    }

    function buyNFT(address nft, uint256 tokenId) external payable {
        Listing storage listing = listings[nft][tokenId];
        require(listing.active, "Not listed");
        require(msg.value >= listing.price, "Insufficient payment");
        listing.active = false;
        payable(listing.seller).transfer(msg.value);
        emit Sold(nft, tokenId, msg.sender);
    }
}
