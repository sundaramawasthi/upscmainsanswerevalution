// server.js
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();

// Enable CORS for all origins (adjust for your security needs)
app.use(cors());

// Increase payload size limit to 50mb
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));

// Simple test route
app.get("/", (req, res) => {
  res.json({ message: "UPSC Mains API is running!" });
});

// Example AI evaluate endpoint (dummy response for now)
app.post("/evaluate", (req, res) => {
  const { pdfBase64, answer, language } = req.body;

  // Log some info to verify
  console.log(`Received evaluation request - size: ${pdfBase64?.length || 0} chars`);

  if (!pdfBase64) {
    return res.status(400).json({ error: "Missing pdfBase64 data" });
  }

  // Dummy scoring logic - replace with real AI evaluation logic
  let score = "80%";
  let feedback = `Your answer was received. (Language: ${language || "not specified"})`;

  res.json({ score, feedback });
});

// Start server
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
