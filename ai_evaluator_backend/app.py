const pdfParse = require('pdf-parse');

exports.handler = async function(event, context) {
  try {
    const requestBody = JSON.parse(event.body);
    const pdfBase64 = requestBody.pdfBase64;

    if (!pdfBase64) {
      return { statusCode: 400, body: 'No PDF data provided' };
    }

    const pdfBuffer = Buffer.from(pdfBase64, 'base64');
    const data = await pdfParse(pdfBuffer);
    const text = data.text.toLowerCase();

    const keywords = [
      'economy', 'development', 'policy', 'agriculture', 'governance',
      'reform', 'education', 'infrastructure', 'technology'
    ];

    let score = 0;
    keywords.forEach(keyword => {
      if (text.includes(keyword)) score++;
    });

    return { statusCode: 200, body: JSON.stringify({ score, extractedText: text }) };
  } catch (err) {
    return { statusCode: 500, body: 'Error processing PDF' };
  }
};
