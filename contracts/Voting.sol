// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Structure to represent each candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping to store candidate ID to Candidate object
    mapping(uint => Candidate) public candidates;

    // Mapping to track whether an address has voted
    mapping(address => bool) public voters;

    // Total number of candidates
    uint public candidatesCount;

    // Event to notify when a vote is cast
    event votedEvent (
        uint indexed candidateId
    );

    // Constructor to initialize the contract with candidates
    constructor() {
        addCandidate("Alice");
        addCandidate("Bob");
    }

    // Function to add a candidate
    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Function to vote for a candidate
    function vote(uint _candidateId) public {
        // Ensure the voter has not already voted
        require(!voters[msg.sender], "You have already voted.");

        // Ensure the candidate ID is valid
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");

        // Record that the voter has voted
        voters[msg.sender] = true;

        // Increment the vote count for the candidate
        candidates[_candidateId].voteCount++;

        // Emit the voting event
        emit votedEvent(_candidateId);
    }

    // Function to get the total vote count for a candidate
    function getVoteCount(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");
        return candidates[_candidateId].voteCount;
    }

    // Function to get the name of a candidate by their ID
    function getCandidateName(uint _candidateId) public view returns (string memory) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");
        return candidates[_candidateId].name;
    }
}
