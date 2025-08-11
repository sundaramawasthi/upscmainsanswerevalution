const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const pdfParse = require("pdf-parse");

const app = express();

app.use(cors());

// Increase payload size limit to 50mb to avoid "payload too large" errors
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));

app.get("/", (req, res) => {
  res.json({ message: "UPSC Mains API is running!" });
});

app.post("/evaluate", async (req, res) => {
  const { pdfBase64, language } = req.body;

  console.log(`Received evaluation request - pdfBase64 length: ${pdfBase64?.length || 0}`);

  if (!pdfBase64) {
    return res.status(400).json({ error: "Missing pdfBase64 data" });
  }

  try {
    // Decode base64 string to Buffer
    const pdfBuffer = Buffer.from(pdfBase64, "base64");

    // Extract text from PDF buffer
    const data = await pdfParse(pdfBuffer);
    const text = data.text.toLowerCase();

    // Simple keyword list (customize as needed)
    const keywords = [
      "economy",
      "development",
      "policy",
      "agriculture",
      "governance",
      "reform",
      "education",
      "infrastructure",
      "technology",
    ];

    // Count matched keywords
    let matchedCount = 0;
    keywords.forEach((keyword) => {
      if (text.includes(keyword)) matchedCount++;
    });

    const scorePercent = ((matchedCount / keywords.length) * 100).toFixed(0);
    const feedback = `Keywords matched: ${matchedCount} out of ${keywords.length}`;

    res.json({
      score: `${scorePercent}%`,
      feedback,
      language: language || "not specified",
    });
  } catch (error) {
    console.error("Error parsing PDF:", error);
    res.status(500).json({ error: "Failed to parse PDF and evaluate" });
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
