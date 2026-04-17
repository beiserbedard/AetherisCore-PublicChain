// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisYieldFarming {
    struct Farm {
        uint256 totalStaked;
        uint256 rewardPerSecond;
    }

    mapping(uint256 => Farm) public farms;
    event FarmStaked(uint256 indexed farmId, address indexed user, uint256 amount);

    function stake(uint256 farmId, uint256 amount) external {
        farms[farmId].totalStaked += amount;
        emit FarmStaked(farmId, msg.sender, amount);
    }
}
