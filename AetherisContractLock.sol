// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisContractLock {
    uint256 public unlockTime;
    address public owner;

    constructor(uint256 _unlockTime) {
        unlockTime = block.timestamp + _unlockTime;
        owner = msg.sender;
    }

    function withdraw() external {
        require(block.timestamp >= unlockTime, "Locked");
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }
}
