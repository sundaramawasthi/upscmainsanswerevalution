import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI PDF Evaluation Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const answerevalute(),
    );
  }
}

class answerevalute extends StatefulWidget {
  const answerevalute({super.key});

  @override
  State<answerevalute> createState() => _answerevaluteState();
}

class _answerevaluteState extends State<answerevalute> {
  final _formKey = GlobalKey<FormState>();

  String? examType;
  String? subject;
  int? totalMarks;

  PlatformFile? selectedPdf;

  bool isLoading = false;

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: kIsWeb,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedPdf = result.files.first;
      });
    }
  }

  Future<String> extractPdfText() async {
    if (kIsWeb) {
      // Web: Cannot extract PDF text easily
      return "PDF text extraction not supported on Web in this demo.";
    } else {
      if (selectedPdf == null) return "";

      try {
        final file = File(selectedPdf!.path!);
        final bytes = await file.readAsBytes();
        final PdfDocument document = PdfDocument(inputBytes: bytes);
        String text = PdfTextExtractor(document).extractText();
        document.dispose();
        return text;
      } catch (e) {
        return "Failed to extract PDF text: $e";
      }
    }
  }

  Future<Map<String, dynamic>> simulateAIEvaluation({
    required String question,
    required String answerText,
    required String subject,
    required String examType,
    required int totalMarks,
  }) async {
    await Future.delayed(const Duration(seconds: 3));

    return {
      "candidate": "Sundram Awasthi",
      "subject": subject,
      "examType": examType,
      "totalMarks": totalMarks,
      "question": question,
      "answer": answerText,
      "analysis":
      "The introduction is relevant but could be more engaging. You correctly identified key issues such as materialism and ethical erosion, showing good grasp. However, arguments would benefit from contemporary examples and deeper elaboration.",
      "strengths":
      "- Good use of philosophical concepts like the 'knower-doer split'.\n- Integration of multiple ethical traditions.\n- Clear structure.",
      "areasToImprove":
      "- Add modern examples (social media ethics, vaccine nationalism).\n- Discuss technology's impact on ethics.\n- Provide detailed consequences and solutions.\n- Stronger conclusion.",
      "conclusion":
      "Benjamin Franklin said, 'A great part of the miseries of mankind is brought upon them by false estimates of value.' Your conclusion is sound but could be strengthened with specific restoration steps.",
      "overallComments":
      "Good understanding demonstrated. Deeper analysis and richer examples will elevate this answer. Keep pushing!",
      "estimatedScore": "4.5 / $totalMarks",
    };
  }

  Future<void> submitForEvaluation() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedPdf == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a PDF file to upload.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final pdfText = await extractPdfText();

    const questionText =
        "Vision of ethical value in modern time is faced to narrow perception of good life. Discuss?";

    final evaluationData = await simulateAIEvaluation(
      question: questionText,
      answerText: pdfText,
      subject: subject!,
      examType: examType!,
      totalMarks: totalMarks!,
    );

    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MentorEvaluationScreen(
          evaluationData: evaluationData,
          pdfName: selectedPdf!.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submit PDF for Evaluation")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upload your answer PDF for evaluation",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select Exam Type",
                  border: OutlineInputBorder(),
                ),
                value: examType,
                items: const [
                  DropdownMenuItem(value: "Prelims", child: Text("Prelims")),
                  DropdownMenuItem(value: "Mains", child: Text("Mains")),
                ],
                onChanged: (val) => setState(() => examType = val),
                validator: (val) =>
                val == null ? "Please select the exam type" : null,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select Subject",
                  border: OutlineInputBorder(),
                ),
                value: subject,
                items: const [
                  DropdownMenuItem(value: "GS", child: Text("General Studies")),
                  DropdownMenuItem(value: "Optional", child: Text("Optional")),
                  DropdownMenuItem(value: "Essay", child: Text("Essay")),
                ],
                onChanged: (val) => setState(() => subject = val),
                validator: (val) =>
                val == null ? "Please select the subject" : null,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: "Select Total Marks",
                  border: OutlineInputBorder(),
                ),
                value: totalMarks,
                items: const [
                  DropdownMenuItem(value: 15, child: Text("15")),
                  DropdownMenuItem(value: 20, child: Text("20")),
                  DropdownMenuItem(value: 10, child: Text("10")),
                ],
                onChanged: (val) => setState(() => totalMarks = val),
                validator: (val) =>
                val == null ? "Please select total marks" : null,
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: pickPdf,
                icon: const Icon(Icons.upload_file),
                label: Text(selectedPdf == null
                    ? "Select PDF file"
                    : "Selected: ${selectedPdf!.name}"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : submitForEvaluation,
                  child: isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text("Submit for Evaluation"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MentorEvaluationScreen extends StatefulWidget {
  final Map<String, dynamic> evaluationData;
  final String pdfName;

  const MentorEvaluationScreen({
    super.key,
    required this.evaluationData,
    required this.pdfName,
  });

  @override
  State<MentorEvaluationScreen> createState() => _MentorEvaluationScreenState();
}

class _MentorEvaluationScreenState extends State<MentorEvaluationScreen> {
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = List.generate(9, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final eval = widget.evaluationData;
    final theme = Theme.of(context).textTheme;

    final sections = [
      {"title": "Candidate", "content": eval["candidate"] ?? ""},
      {
        "title": "Subject & Exam",
        "content":
        "Subject: ${eval["subject"]} | Exam: ${eval["examType"]} | Total Marks: ${eval["totalMarks"]}"
      },
      {"title": "Question", "content": eval["question"] ?? ""},
      {"title": "Your Answer", "content": eval["answer"] ?? ""},
      {"title": "Analysis", "content": eval["analysis"] ?? ""},
      {"title": "Strengths", "content": eval["strengths"] ?? ""},
      {"title": "Areas to Improve", "content": eval["areasToImprove"] ?? ""},
      {"title": "Conclusion", "content": eval["conclusion"] ?? ""},
      {
        "title": "Overall Comments & Score",
        "content":
        "${eval["overallComments"] ?? ""}\n\nEstimated Score: ${eval["estimatedScore"] ?? ""}"
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Mentor Evaluation")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            animationDuration: const Duration(milliseconds: 300),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _expanded[index] = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      section["title"]!,
                      style:
                      theme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                body: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SelectableText(
                    section["content"]!,
                    style: theme.bodyMedium,
                  ),
                ),
                isExpanded: _expanded[index],
              ),
            ],
          );
        },
      ),
    );
  }
}
