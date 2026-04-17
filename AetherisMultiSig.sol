// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisMultiSig {
    address[] public owners;
    uint256 public requiredConfirmations;
    mapping(uint256 => mapping(address => bool)) public confirmations;

    struct Transaction {
        address to;
        uint256 value;
        bool executed;
    }

    Transaction[] public transactions;

    event TransactionSubmitted(uint256 indexed txId);
    event TransactionConfirmed(uint256 indexed txId);
    event TransactionExecuted(uint256 indexed txId);

    constructor(address[] memory _owners, uint256 _required) {
        owners = _owners;
        requiredConfirmations = _required;
    }

    function submitTransaction(address to, uint256 value) external returns(uint256) {
        uint256 txId = transactions.length;
        transactions.push(Transaction({
            to: to,
            value: value,
            executed: false
        }));
        emit TransactionSubmitted(txId);
        return txId;
    }

    function confirmTransaction(uint256 txId) external {
        require(!confirmations[txId][msg.sender], "Already confirmed");
        confirmations[txId][msg.sender] = true;
        emit TransactionConfirmed(txId);
    }

    function executeTransaction(uint256 txId) external {
        Transaction storage tx = transactions[txId];
        require(!tx.executed, "Already executed");
        uint256 count = 0;
        for (uint256 i = 0; i < owners.length; i++) {
            if (confirmations[txId][owners[i]]) count++;
        }
        require(count >= requiredConfirmations, "Not enough confirmations");
        tx.executed = true;
        payable(tx.to).transfer(tx.value);
        emit TransactionExecuted(txId);
    }
}
