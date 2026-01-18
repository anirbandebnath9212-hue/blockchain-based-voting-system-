const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Voting", function () {
  let voting, owner, voter1;

  beforeEach(async () => {
    [owner, voter1] = await ethers.getSigners();

    const Voting = await ethers.getContractFactory("Voting");
    voting = await Voting.deploy(["Alice", "Bob"]);
    await voting.waitForDeployment();
  });

  it("should allow voting when open", async () => {
    await voting.startVoting();
    await voting.connect(voter1).vote(0);

    const candidate = await voting.getCandidate(0);
    expect(candidate[1]).to.equal(1);
  });

  it("should prevent double voting", async () => {
    await voting.startVoting();
    await voting.connect(voter1).vote(0);

    await expect(
      voting.connect(voter1).vote(0)
    ).to.be.revertedWith("Already voted");
  });
});
