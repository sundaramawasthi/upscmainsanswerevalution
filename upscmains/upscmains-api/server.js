// server.js
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Simple test endpoint
app.get("/", (req, res) => {
  res.json({ message: "UPSC Mains API is running!" });
});

// Example AI evaluate endpoint (dummy for now)
app.post("/evaluate", (req, res) => {
  const { answer } = req.body;
  res.json({ score: "80%", feedback: `Your answer was: ${answer}` });
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
