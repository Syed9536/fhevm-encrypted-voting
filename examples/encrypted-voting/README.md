# Encrypted Voting — FHEVM Example

This minimal example demonstrates:
- Storing encrypted votes on-chain (as bytes)
- Registering a voter
- Submitting an encrypted vote
- Owner publishing an encrypted tally (event)

NOTE: This demo uses placeholder ciphertext (UTF-8 bytes). To use real FHE ciphertext, integrate Zama SDK encryption in frontend/coprocessor as per Zama docs.

## Run locally (from repo root)
npm install
npx hardhat compile
npx hardhat test ./examples/encrypted-voting/test/encryptedVoting.test.js

## Files
- contracts/EncryptedVoting.sol
- test/encryptedVoting.test.js
