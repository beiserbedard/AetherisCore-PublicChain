// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisNFT {
    string public name = "Aetheris Genesis Node";
    string public symbol = "AETHN";
    uint256 public tokenIdCounter;
    
    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public balanceOf;
    mapping(uint256 => string) public tokenURI;

    event Minted(address indexed to, uint256 tokenId);
    event Transfered(address indexed from, address indexed to, uint256 tokenId);

    function mint(address to, string calldata uri) external {
        uint256 tokenId = tokenIdCounter++;
        ownerOf[tokenId] = to;
        balanceOf[to]++;
        tokenURI[tokenId] = uri;
        emit Minted(to, tokenId);
    }

    function transfer(address to, uint256 tokenId) external {
        require(ownerOf[tokenId] == msg.sender, "Not owner");
        require(to != address(0), "Zero address");
        
        balanceOf[msg.sender]--;
        balanceOf[to]++;
        ownerOf[tokenId] = to;
        emit Transfered(msg.sender, to, tokenId);
    }

    function getTokenURI(uint256 tokenId) external view returns(string memory) {
        return tokenURI[tokenId];
    }
}
