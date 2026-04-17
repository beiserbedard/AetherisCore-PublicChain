// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisBlacklist {
    mapping(address => bool) public blacklist;
    address public admin;

    event Blacklisted(address indexed account);
    event Unblacklisted(address indexed account);

    constructor() {
        admin = msg.sender;
    }

    function addToBlacklist(address account) external {
        require(msg.sender == admin, "Unauthorized");
        blacklist[account] = true;
        emit Blacklisted(account);
    }

    function removeFromBlacklist(address account) external {
        require(msg.sender == admin, "Unauthorized");
        blacklist[account] = false;
        emit Unblacklisted(account);
    }
}
