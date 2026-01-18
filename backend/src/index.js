const express = require("express");
const cors = require("cors");
require("dotenv").config();

const votingRoutes = require("./routes/voting.routes");

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Health check (very useful)
app.get("/", (req, res) => {
  res.send("Backend is running 🚀");
});

// Voting APIs
app.use("/api", votingRoutes);

// Start server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Backend running on http://localhost:${PORT}`);
});
