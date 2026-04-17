// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisAutoCompound {
    address public stakingContract;
    event Compounded(address indexed user);

    constructor(address stake) {
        stakingContract = stake;
    }

    function compound(address user) external {
        emit Compounded(user);
    }
}
