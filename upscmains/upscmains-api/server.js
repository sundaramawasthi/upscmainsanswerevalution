// server.js
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Simple health check
app.get('/', (req, res) => {
  res.json({ message: 'UPSC Mains API is running!' });
});

// Evaluate endpoint
app.post('/evaluate', (req, res) => {
  const { pdfBase64, language } = req.body;

  // Dummy evaluation logic
  let score = '80%';
  let feedback = 'Your answer was evaluated successfully.';

  if (language === 'fr') {
    score = '85%';
    feedback = 'Ceci est une réponse évaluée en français.';
  }

  // Return JSON response
  res.json({ score, feedback });
});

// Listen on environment port or 3000
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
