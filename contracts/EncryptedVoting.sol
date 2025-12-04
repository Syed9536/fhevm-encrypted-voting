// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Encrypted Voting (FHE example)
/// @notice Minimal example storing encrypted votes and publishing an encrypted tally.
/// NOTE: This demo uses simple bytes ciphertext placeholders. Replace with Zama SDK output
/// and euint types for real FHE integration following Zama docs.
contract EncryptedVoting {
    address public owner;

    mapping(address => bytes) public encryptedVote;
    mapping(address => bool) public registered;

    event VoteSubmitted(address indexed voter);
    event TallyPublished(bytes ciphertextTally);

    constructor() {
        owner = msg.sender;
    }

    // Simple registration to prevent anonymous submissions in demo
    function register() external {
        registered[msg.sender] = true;
    }

    // Submit encrypted vote bytes (ciphertext)
    function submitEncryptedVote(bytes calldata ciphertext) external {
        require(registered[msg.sender], "not registered");
        require(encryptedVote[msg.sender].length == 0, "already voted");
        encryptedVote[msg.sender] = ciphertext;
        emit VoteSubmitted(msg.sender);
    }

    // Owner publishes encrypted tally (computed off-chain by a coprocessor)
    function publishEncryptedTally(bytes calldata ciphertextTally) external {
        require(msg.sender == owner, "only owner can publish");
        emit TallyPublished(ciphertextTally);
    }
}
