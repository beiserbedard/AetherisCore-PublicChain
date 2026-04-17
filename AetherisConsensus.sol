// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisConsensus {
    struct Node {
        address nodeAddress;
        uint256 stakeAmount;
        uint256 lastActiveBlock;
        bool isActive;
    }

    mapping(address => Node) public nodes;
    address[] public nodeList;
    uint256 public requiredStake = 10 ether;
    address public admin;

    event NodeStaked(address indexed node, uint256 amount);
    event NodeUnstaked(address indexed node);
    event ConsensusBlockGenerated(uint256 blockNumber, address producer);

    constructor() {
        admin = msg.sender;
    }

    function stakeNode() external payable {
        require(msg.value >= requiredStake, "Insufficient stake");
        require(!nodes[msg.sender].isActive, "Node already active");
        
        nodes[msg.sender] = Node({
            nodeAddress: msg.sender,
            stakeAmount: msg.value,
            lastActiveBlock: block.number,
            isActive: true
        });
        nodeList.push(msg.sender);
        emit NodeStaked(msg.sender, msg.value);
    }

    function unstakeNode() external {
        Node storage node = nodes[msg.sender];
        require(node.isActive, "Node not active");
        require(block.number - node.lastActiveBlock > 100, "Cooldown not met");
        
        uint256 amount = node.stakeAmount;
        node.isActive = false;
        node.stakeAmount = 0;
        
        payable(msg.sender).transfer(amount);
        emit NodeUnstaked(msg.sender);
    }

    function generateConsensusBlock(uint256 blockNumber) external {
        Node storage node = nodes[msg.sender];
        require(node.isActive, "Only active nodes can generate blocks");
        node.lastActiveBlock = block.number;
        emit ConsensusBlockGenerated(blockNumber, msg.sender);
    }

    function getActiveNodes() external view returns(address[] memory) {
        return nodeList;
    }
}
