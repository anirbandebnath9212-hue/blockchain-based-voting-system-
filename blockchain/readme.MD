# 🗳️ Blockchain Based Voting System

A simple blockchain-based voting system built using **Solidity**, **Hardhat**, and **ethers.js**.  
This project demonstrates how to deploy and interact with a smart contract for secure, tamper-proof voting on Ethereum (local network first).

---

## 📌 Tech Stack

- **Solidity** – Smart contract language
- **Hardhat (v2)** – Ethereum development environment
- **ethers.js (v6)** – Blockchain interaction
- **Node.js** – Runtime environment

---

## 📂 Project Structure

blockchain_based_voting_system/
│
├── blockchain/
│ ├── contracts/
│ │ └── Voting.sol
│ ├── scripts/
│ │ └── deploy.js
│ ├── test/
│ ├── hardhat.config.js
│ └── package.json
│
└── README.md

---

## ⚙️ Prerequisites

Make sure you have the following installed:

- **Node.js** (v18 or later recommended)
- **npm** (comes with Node.js)
- **Git**

Check versions:

```bash
node -v
npm -v
git --version
```

🚀 Setup Instructions (Step-by-Step)

1️⃣ Clone the repository

git clone <your-repo-url>
cd blockchain_based_voting_system/blockchain

2️⃣ Install dependencies

npm install

3️⃣ Compile the smart contracts

npx hardhat compile

Expected output:

Compiled 1 Solidity file successfully

4️⃣ Deploy the Voting contract (local blockchain)

npx hardhat run scripts/deploy.js

Expected output:

Voting deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3

🧪 Interacting with the Contract (Local)

1️⃣ Open Hardhat console

npx hardhat console

2️⃣ Attach to the deployed contract

const Voting = await ethers.getContractFactory("Voting");
const voting = await Voting.attach(
"PASTE_DEPLOYED_CONTRACT_ADDRESS_HERE"
);

3️⃣ Start voting (owner only)

await voting.startVoting();

4️⃣ Vote from another account

const [owner, voter1] = await ethers.getSigners();
await voting.connect(voter1).vote(0);

5️⃣ Read vote results

await voting.getCandidate(0);
Example output:

[ 'Alice', 1n ]
