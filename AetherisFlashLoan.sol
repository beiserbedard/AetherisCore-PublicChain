// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisFlashLoan {
    uint256 public fee = 1e15;
    event FlashLoan(address indexed borrower, uint256 amount, uint256 fee);

    function flashLoan(uint256 amount) external {
        payable(msg.sender).transfer(amount);
        uint256 repay = amount + fee;
        require(address(this).balance >= repay, "Repay failed");
        emit FlashLoan(msg.sender, amount, fee);
    }
}
