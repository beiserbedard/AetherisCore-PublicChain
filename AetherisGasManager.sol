// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisGasManager {
    uint256 public baseGasPrice = 10 gwei;
    uint256 public gasAdjustment = 100;

    event GasPriceUpdated(uint256 newPrice);

    function getCurrentGasPrice() external view returns(uint256) {
        return baseGasPrice * gasAdjustment / 100;
    }

    function adjustGas(uint256 adjustment) external {
        gasAdjustment = adjustment;
        emit GasPriceUpdated(baseGasPrice * adjustment / 100);
    }
}
