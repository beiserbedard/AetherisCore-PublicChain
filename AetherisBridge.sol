// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisBridge {
    struct CrossChainTx {
        uint256 amount;
        address sender;
        address recipient;
        uint256 sourceChainId;
        uint256 targetChainId;
        bool executed;
    }

    mapping(bytes32 => CrossChainTx) public crossChainTxs;
    address public validator;
    event CrossChainInitiated(bytes32 indexed txHash, uint256 targetChain);
    event CrossChainExecuted(bytes32 indexed txHash);

    constructor() {
        validator = msg.sender;
    }

    function initiateCrossChain(
        address recipient,
        uint256 amount,
        uint256 sourceChain,
        uint256 targetChain
    ) external payable returns(bytes32) {
        require(msg.value == amount, "Amount mismatch");
        bytes32 txHash = keccak256(abi.encodePacked(msg.sender, recipient, amount, block.timestamp));
        crossChainTxs[txHash] = CrossChainTx({
            amount: amount,
            sender: msg.sender,
            recipient: recipient,
            sourceChainId: sourceChain,
            targetChainId: targetChain,
            executed: false
        });
        emit CrossChainInitiated(txHash, targetChain);
        return txHash;
    }

    function executeCrossChain(bytes32 txHash) external {
        require(msg.sender == validator, "Only validator");
        CrossChainTx storage txData = crossChainTxs[txHash];
        require(!txData.executed, "Already executed");
        txData.executed = true;
        payable(txData.recipient).transfer(txData.amount);
        emit CrossChainExecuted(txHash);
    }
}
