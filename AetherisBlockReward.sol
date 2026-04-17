// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisBlockReward {
    uint256 public blockReward = 5 ether;
    address public consensusContract;

    constructor(address consensus) {
        consensusContract = consensus;
    }

    event RewardDistributed(address indexed producer, uint256 amount);

    function distributeReward(address producer) external {
        require(msg.sender == consensusContract, "Unauthorized");
        payable(producer).transfer(blockReward);
        emit RewardDistributed(producer, blockReward);
    }

    function updateReward(uint256 newReward) external {
        blockReward = newReward;
    }
}
