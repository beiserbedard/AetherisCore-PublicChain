// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisAirdrop {
    mapping(address => bool) public claimed;
    uint256 public airdropAmount = 100 ether;

    event AirdropClaimed(address indexed user, uint256 amount);

    function claim() external {
        require(!claimed[msg.sender], "Already claimed");
        claimed[msg.sender] = true;
        payable(msg.sender).transfer(airdropAmount);
        emit AirdropClaimed(msg.sender, airdropAmount);
    }
}
