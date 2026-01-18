const { ethers } = require("ethers");
const wallet = require("./provider");
const VotingABI = require("./VotingABI.json");

const contractAddress =
  "0x5FbDB2315678afecb367f032d93F642f64180aa3";

const votingContract = new ethers.Contract(
  contractAddress,
  VotingABI,
  wallet
);

module.exports = votingContract;