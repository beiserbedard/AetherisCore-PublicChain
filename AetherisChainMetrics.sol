// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisChainMetrics {
    uint256 public totalBlocks;
    uint256 public totalTransactions;
    uint256 public activeAccounts;

    event BlockAdded(uint256 total);
    event TransactionAdded(uint256 total);

    function incrementBlocks() external {
        totalBlocks++;
        emit BlockAdded(totalBlocks);
    }

    function incrementTransactions() external {
        totalTransactions++;
        emit TransactionAdded(totalTransactions);
    }

    function updateActiveAccounts(uint256 count) external {
        activeAccounts = count;
    }
}
