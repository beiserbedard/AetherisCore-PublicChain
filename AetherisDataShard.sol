// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisDataShard {
    struct DataRecord {
        string cid;
        uint256 timestamp;
        address uploader;
    }

    mapping(uint256 => DataRecord[]) public shards;
    uint256 public shardCount;
    event DataUploaded(uint256 indexed shardId, string cid, address uploader);

    function uploadData(uint256 shardId, string calldata cid) external {
        shards[shardId].push(DataRecord({
            cid: cid,
            timestamp: block.timestamp,
            uploader: msg.sender
        }));
        if (shardId >= shardCount) shardCount = shardId + 1;
        emit DataUploaded(shardId, cid, msg.sender);
    }

    function getShardData(uint256 shardId) external view returns(DataRecord[] memory) {
        return shards[shardId];
    }
}
