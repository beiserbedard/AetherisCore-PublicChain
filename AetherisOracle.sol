// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisOracle {
    struct PriceData {
        uint256 price;
        uint256 timestamp;
    }

    mapping(string => PriceData) public priceFeeds;
    address public oracleAdmin;
    event PriceUpdated(string indexed symbol, uint256 price, uint256 time);

    constructor() {
        oracleAdmin = msg.sender;
    }

    function updatePrice(string calldata symbol, uint256 price) external {
        require(msg.sender == oracleAdmin, "Unauthorized");
        priceFeeds[symbol] = PriceData({
            price: price,
            timestamp: block.timestamp
        });
        emit PriceUpdated(symbol, price, block.timestamp);
    }

    function getPrice(string calldata symbol) external view returns(uint256, uint256) {
        PriceData memory data = priceFeeds[symbol];
        return (data.price, data.timestamp);
    }
}
