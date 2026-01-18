const express = require("express");
const router = express.Router();
const votingContract = require("../blockchain/votingContract");

// Get candidates
router.get("/candidates", async (req, res) => {
  const count = await votingContract.getCandidatesCount();
  const result = [];

  for (let i = 0; i < count; i++) {
    const [name, votes] =
      await votingContract.getCandidate(i);

    result.push({
      index: i,
      name,
      votes: votes.toString(),
    });
  }

  res.json(result);
});

// Cast vote
router.post("/vote", async (req, res) => {
  const { candidateIndex } = req.body;

  const tx = await votingContract.vote(candidateIndex);
  await tx.wait();

  res.json({ success: true });
});

module.exports = router;