// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisWhitelist {
    mapping(address => bool) public whitelist;
    address public admin;

    event Whitelisted(address indexed account);
    event Removed(address indexed account);

    constructor() {
        admin = msg.sender;
    }

    function addToWhitelist(address account) external {
        require(msg.sender == admin, "Unauthorized");
        whitelist[account] = true;
        emit Whitelisted(account);
    }

    function removeFromWhitelist(address account) external {
        require(msg.sender == admin, "Unauthorized");
        whitelist[account] = false;
        emit Removed(account);
    }
}
