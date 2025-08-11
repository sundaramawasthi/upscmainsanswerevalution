const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const pdfParse = require("pdf-parse");

const app = express();
app.use(cors());
app.use(bodyParser.json({ limit: "10mb" }));

app.get("/", (req, res) => {
  res.json({ message: "UPSC Mains API is running!" });
});

app.post("/evaluate", async (req, res) => {
  try {
    const { pdfBase64 } = req.body;

    if (!pdfBase64) {
      return res.status(400).json({ error: "pdfBase64 is required" });
    }

    const pdfBuffer = Buffer.from(pdfBase64, "base64");

    const data = await pdfParse(pdfBuffer);
    const text = data.text.toLowerCase();

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

    let score = 0;
    keywords.forEach((keyword) => {
      if (text.includes(keyword)) score++;
    });

    res.json({
      score: ((score / keywords.length) * 100).toFixed(2),
      extractedText: text,
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({ error: error.message || "Internal server error" });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
