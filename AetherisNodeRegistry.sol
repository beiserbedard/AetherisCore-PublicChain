// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisNodeRegistry {
    struct NodeInfo {
        string endpoint;
        uint256 chainId;
        bool verified;
    }

    mapping(address => NodeInfo) public nodes;
    address public admin;

    event NodeRegistered(address indexed node, string endpoint);
    event NodeVerified(address indexed node);

    constructor() {
        admin = msg.sender;
    }

    function registerNode(string calldata endpoint, uint256 chainId) external {
        nodes[msg.sender] = NodeInfo({
            endpoint: endpoint,
            chainId: chainId,
            verified: false
        });
        emit NodeRegistered(msg.sender, endpoint);
    }

    function verifyNode(address node) external {
        require(msg.sender == admin, "Only admin");
        nodes[node].verified = true;
        emit NodeVerified(node);
    }
}
