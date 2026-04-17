// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisTimeLock {
    uint256 public delay = 2 days;
    mapping(bytes32 => uint256) public queue;

    event Queued(bytes32 indexed tx, uint256 executeTime);
    event Executed(bytes32 indexed tx);

    function queueTransaction(bytes32 txHash) external {
        uint256 executeTime = block.timestamp + delay;
        queue[txHash] = executeTime;
        emit Queued(txHash, executeTime);
    }

    function executeTransaction(bytes32 txHash) external {
        require(queue[txHash] <= block.timestamp, "Not ready");
        queue[txHash] = 0;
        emit Executed(txHash);
    }
}
