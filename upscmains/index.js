const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { Storage } = require("@google-cloud/storage");
const pdfParse = require("pdf-parse"); // Ensure this is installed via npm

admin.initializeApp();

const storage = new Storage();

exports.evaluateAnswer = functions.storage.object().onFinalize(async (object) => {
  const bucket = storage.bucket(object.bucket);
  const file = bucket.file(object.name);

  try {
    // Download file as buffer
    const [fileBuffer] = await file.download();

    // Extract text from PDF buffer
    const data = await pdfParse(fileBuffer);
    const text = data.text.toLowerCase();

    const port = process.env.PORT || 3000;
     app.listen(port, () => {
     console.log(`Server running on port ${port}`);
     });


    // Keywords for evaluation
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

    // Calculate score based on keyword presence
    let score = 0;
    keywords.forEach((keyword) => {
      if (text.includes(keyword)) score++;
    });

    // Save result to Firestore
    const db = admin.firestore();
    await db.collection("evaluations").add({
      fileName: object.name,
      score,
      extractedText: text,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`Evaluation saved for file: ${object.name} with score: ${score}`);
  } catch (error) {
    console.error("Error processing file:", error);
  }

  return null;
});
