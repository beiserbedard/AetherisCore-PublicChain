// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AetherisGovernance {
    struct Proposal {
        string title;
        string description;
        uint256 voteStart;
        uint256 voteEnd;
        uint256 forVotes;
        uint256 againstVotes;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    uint256 public votingPeriod = 3 days;

    event ProposalCreated(uint256 indexed id, string title);
    event VoteCast(uint256 indexed id, address indexed voter, bool support);
    event ProposalExecuted(uint256 indexed id);

    function createProposal(string calldata title, string calldata description) external {
        proposals.push(Proposal({
            title: title,
            description: description,
            voteStart: block.timestamp,
            voteEnd: block.timestamp + votingPeriod,
            forVotes: 0,
            againstVotes: 0,
            executed: false
        }));
        emit ProposalCreated(proposals.length - 1, title);
    }

    function castVote(uint256 proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal");
        Proposal storage prop = proposals[proposalId];
        require(block.timestamp >= prop.voteStart && block.timestamp <= prop.voteEnd, "Voting closed");
        require(!hasVoted[proposalId][msg.sender], "Already voted");

        hasVoted[proposalId][msg.sender] = true;
        if (support) prop.forVotes++;
        else prop.againstVotes++;

        emit VoteCast(proposalId, msg.sender, support);
    }

    function executeProposal(uint256 proposalId) external {
        Proposal storage prop = proposals[proposalId];
        require(block.timestamp > prop.voteEnd, "Voting not ended");
        require(!prop.executed, "Already executed");
        require(prop.forVotes > prop.againstVotes, "Rejected");
        prop.executed = true;
        emit ProposalExecuted(proposalId);
    }

    function getProposalCount() external view returns(uint256) {
        return proposals.length;
    }
}
