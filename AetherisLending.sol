// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisLending {
    struct Loan {
        uint256 collateral;
        uint256 borrowAmount;
        uint256 startTime;
        bool active;
    }

    mapping(address => Loan) public userLoans;
    uint256 public collateralRatio = 150;

    event LoanTaken(address indexed user, uint256 borrow, uint256 collateral);
    event LoanRepaid(address indexed user);

    function takeLoan(uint256 borrowAmount) external payable {
        uint256 requiredCollateral = borrowAmount * collateralRatio / 100;
        require(msg.value >= requiredCollateral, "Insufficient collateral");
        require(!userLoans[msg.sender].active, "Loan active");
        
        userLoans[msg.sender] = Loan({
            collateral: msg.value,
            borrowAmount: borrowAmount,
            startTime: block.timestamp,
            active: true
        });
        payable(msg.sender).transfer(borrowAmount);
        emit LoanTaken(msg.sender, borrowAmount, msg.value);
    }

    function repayLoan() external payable {
        Loan storage loan = userLoans[msg.sender];
        require(loan.active, "No active loan");
        require(msg.value >= loan.borrowAmount, "Insufficient repayment");
        
        uint256 collateral = loan.collateral;
        loan.active = false;
        payable(msg.sender).transfer(collateral);
        emit LoanRepaid(msg.sender);
    }
}
