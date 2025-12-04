const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EncryptedVoting (example)", function () {
  it("allows register & submit encrypted vote", async function () {
    const [owner, voter] = await ethers.getSigners();
    const V = await ethers.getContractFactory("EncryptedVoting");

    // v6 deployment → directly: await V.deploy()
    const v = await V.deploy();

    // register
    await v.connect(voter).register();

    // fake ciphertext
    const fakeCipher = ethers.toUtf8Bytes("ciphertext-vote-1");

    await v.connect(voter).submitEncryptedVote(fakeCipher);

    const stored = await v.encryptedVote(voter.address);
    expect(ethers.toUtf8String(stored)).to.equal("ciphertext-vote-1");
  });

  it("owner can publish encrypted tally and emits event", async function () {
    const [owner] = await ethers.getSigners();
    const V = await ethers.getContractFactory("EncryptedVoting");
    const v = await V.deploy();

    const fakeTally = ethers.toUtf8Bytes("ciphertext-tally");

    await expect(v.publishEncryptedTally(fakeTally)).to.emit(v, "TallyPublished");
  });
});
