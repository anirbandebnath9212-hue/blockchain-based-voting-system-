const hre = require("hardhat");

async function main() {
  const candidateNames = ["Alice", "Bob", "Charlie"];

  const Voting = await hre.ethers.getContractFactory("Voting");
  const voting = await Voting.deploy(candidateNames);

  await voting.waitForDeployment();

  const address = await voting.getAddress();
  console.log("Voting deployed to:", address);

  // ✅ START VOTING IMMEDIATELY
  const tx = await voting.startVoting();
  await tx.wait();

  console.log("✅ Voting has started");
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
