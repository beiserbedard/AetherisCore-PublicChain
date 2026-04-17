// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisDID {
    struct DIDDocument {
        string publicKey;
        string metadata;
        uint256 createTime;
        bool isActive;
    }

    mapping(address => DIDDocument) public didRegistry;
    event DIDCreated(address indexed user, string publicKey);
    event DIDUpdated(address indexed user, string newMetadata);
    event DIDDisabled(address indexed user);

    function createDID(string calldata publicKey, string calldata metadata) external {
        require(bytes(didRegistry[msg.sender].publicKey).length == 0, "DID exists");
        didRegistry[msg.sender] = DIDDocument({
            publicKey: publicKey,
            metadata: metadata,
            createTime: block.timestamp,
            isActive: true
        });
        emit DIDCreated(msg.sender, publicKey);
    }

    function updateDIDMetadata(string calldata newMetadata) external {
        require(bytes(didRegistry[msg.sender].publicKey).length > 0, "DID not found");
        didRegistry[msg.sender].metadata = newMetadata;
        emit DIDUpdated(msg.sender, newMetadata);
    }

    function disableDID() external {
        require(didRegistry[msg.sender].isActive, "DID inactive");
        didRegistry[msg.sender].isActive = false;
        emit DIDDisabled(msg.sender);
    }

    function getDID(address user) external view returns(DIDDocument memory) {
        return didRegistry[user];
    }
}
