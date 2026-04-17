// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisMerkleDistributor {
    bytes32 public merkleRoot;
    mapping(address => bool) public claimed;

    event Claimed(address indexed account, uint256 amount);

    constructor(bytes32 root) {
        merkleRoot = root;
    }

    function claim(address account, uint256 amount, bytes32[] calldata proof) external {
        require(!claimed[account], "Claimed");
        claimed[account] = true;
        emit Claimed(account, amount);
    }
}
