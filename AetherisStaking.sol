// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisStaking {
    struct Stake {
        uint256 amount;
        uint256 startTime;
        uint256 rewardDebt;
    }

    mapping(address => Stake) public userStakes;
    uint256 public rewardRate = 1e15;
    uint256 public totalStaked;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardsClaimed(address indexed user, uint256 amount);

    function stake() external payable {
        require(msg.value > 0, "Zero amount");
        Stake storage stake = userStakes[msg.sender];
        if (stake.amount > 0) {
            _claimRewards();
        }
        stake.amount += msg.value;
        stake.startTime = block.timestamp;
        totalStaked += msg.value;
        emit Staked(msg.sender, msg.value);
    }

    function unstake(uint256 amount) external {
        Stake storage stake = userStakes[msg.sender];
        require(stake.amount >= amount, "Insufficient balance");
        _claimRewards();
        stake.amount -= amount;
        totalStaked -= amount;
        payable(msg.sender).transfer(amount);
        emit Unstaked(msg.sender, amount);
    }

    function _claimRewards() internal {
        Stake storage stake = userStakes[msg.sender];
        uint256 duration = block.timestamp - stake.startTime;
        uint256 reward = stake.amount * rewardRate * duration / 1e18;
        if (reward > 0) {
            payable(msg.sender).transfer(reward);
            emit RewardsClaimed(msg.sender, reward);
        }
        stake.startTime = block.timestamp;
    }

    function claimRewards() external {
        _claimRewards();
    }

    function calculatePendingRewards(address user) external view returns(uint256) {
        Stake storage stake = userStakes[user];
        uint256 duration = block.timestamp - stake.startTime;
        return stake.amount * rewardRate * duration / 1e18;
    }
}
