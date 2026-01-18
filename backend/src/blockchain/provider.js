const { ethers } = require("ethers");

const provider = new ethers.JsonRpcProvider(
  "http://127.0.0.1:8545"
);

const wallet = new ethers.Wallet(
  process.env.PRIVATE_KEY,
  provider
);

module.exports = wallet;
