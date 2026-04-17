// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisSlotMachine {
    event Played(address indexed player, uint256 bet, uint256 prize);

    function play() external payable {
        uint256 prize = 0;
        if (block.timestamp % 5 == 0) prize = msg.value * 2;
        if (prize > 0) payable(msg.sender).transfer(prize);
        emit Played(msg.sender, msg.value, prize);
    }
}
