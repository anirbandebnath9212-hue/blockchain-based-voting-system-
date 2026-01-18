// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    address public owner;
    bool public votingOpen;

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    event VoteCast(address indexed voter, uint256 candidateIndex);
    event VotingStarted();
    event VotingEnded();

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier whenVotingOpen() {
        require(votingOpen, "Voting is closed");
        _;
    }

    constructor(string[] memory candidateNames) {
        owner = msg.sender;
        for (uint256 i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }

    function startVoting() external onlyOwner {
        votingOpen = true;
        emit VotingStarted();
    }

    function endVoting() external onlyOwner {
        votingOpen = false;
        emit VotingEnded();
    }

    function vote(uint256 candidateIndex) external whenVotingOpen {
        require(!hasVoted[msg.sender], "Already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount++;

        emit VoteCast(msg.sender, candidateIndex);
    }

    function getCandidatesCount() external view returns (uint256) {
        return candidates.length;
    }

    function getCandidate(uint256 index)
        external
        view
        returns (string memory name, uint256 voteCount)
    {
        Candidate memory c = candidates[index];
        return (c.name, c.voteCount);
    }
}
