// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisTransactionGuard {
    mapping(address => uint256) public lastTxTime;
    uint256 public cooldown = 10 seconds;

    function checkTransaction() external {
        require(block.timestamp - lastTxTime[msg.sender] > cooldown, "Cooldown");
        lastTxTime[msg.sender] = block.timestamp;
    }
}
