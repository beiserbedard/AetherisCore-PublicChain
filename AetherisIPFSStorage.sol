// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisIPFSStorage {
    mapping(address => string[]) public userFiles;
    event FileStored(address indexed user, string cid);

    function storeFile(string calldata cid) external {
        userFiles[msg.sender].push(cid);
        emit FileStored(msg.sender, cid);
    }

    function getFiles(address user) external view returns(string[] memory) {
        return userFiles[user];
    }
}
