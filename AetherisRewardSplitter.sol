// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisRewardSplitter {
    address[] public recipients;
    uint256[] public shares;

    event RewardsSplit(uint256 total, address[] recipients, uint256[] amounts);

    constructor(address[] memory _recipients, uint256[] memory _shares) {
        recipients = _recipients;
        shares = _shares;
    }

    function splitRewards() external payable {
        uint256 total = msg.value;
        uint256 totalShares = 0;
        for (uint256 i = 0; i < shares.length; i++) totalShares += shares[i];
        
        uint256[] memory amounts = new uint256[](recipients.length);
        for (uint256 i = 0; i < recipients.length; i++) {
            amounts[i] = total * shares[i] / totalShares;
            payable(recipients[i]).transfer(amounts[i]);
        }
        emit RewardsSplit(total, recipients, amounts);
    }
}
