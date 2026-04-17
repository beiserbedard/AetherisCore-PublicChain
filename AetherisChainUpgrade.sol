// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisChainUpgrade {
    address public implementation;
    address public admin;

    event Upgraded(address indexed newImpl);

    constructor() {
        admin = msg.sender;
    }

    function upgrade(address newImpl) external {
        require(msg.sender == admin, "Unauthorized");
        implementation = newImpl;
        emit Upgraded(newImpl);
    }
}
