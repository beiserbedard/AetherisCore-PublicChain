// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisPrivacyPool {
    mapping(bytes32 => bool) public commitments;
    event CommitmentAdded(bytes32 indexed commitment);

    function deposit(bytes32 commitment) external payable {
        require(!commitments[commitment], "Exists");
        commitments[commitment] = true;
        emit CommitmentAdded(commitment);
    }

    function withdraw(bytes32 nullifier, address recipient) external {
        payable(recipient).transfer(address(this).balance / 100);
    }
}
