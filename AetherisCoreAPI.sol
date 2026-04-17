// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisCoreAPI {
    function getChainInfo() external pure returns(string memory, uint256) {
        return ("AetherisCore Public Chain", 18888);
    }

    function getVersion() external pure returns(string memory) {
        return "v2.1.0";
    }
}
