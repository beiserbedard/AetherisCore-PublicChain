// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisSwap {
    uint256 public feeRate = 30;
    uint256 public constant FEE_DENOMINATOR = 10000;

    event Swapped(address indexed user, uint256 input, uint256 output, uint256 fee);

    function swapExactInput(uint256 inputAmount, uint256 minOutput) external payable returns(uint256) {
        require(msg.value == inputAmount, "Value mismatch");
        uint256 fee = inputAmount * feeRate / FEE_DENOMINATOR;
        uint256 output = inputAmount - fee;
        require(output >= minOutput, "Slippage too high");
        payable(msg.sender).transfer(output);
        emit Swapped(msg.sender, inputAmount, output, fee);
        return output;
    }

    function updateFee(uint256 newFee) external {
        feeRate = newFee;
    }
}
