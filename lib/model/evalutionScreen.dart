// 📄 main.dart
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('🔴 Flutter Error: ${details.exceptionAsString()}');
    debugPrintStack(stackTrace: details.stack);
  };

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stack) {
    debugPrint('🚨 Uncaught Zone Error: $error');
    debugPrintStack(stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Evaluator (French API)',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UploadAndEvaluatePage(),
    );
  }
}

class UploadAndEvaluatePage extends StatefulWidget {
  const UploadAndEvaluatePage({super.key});

  @override
  State<UploadAndEvaluatePage> createState() => _UploadAndEvaluatePageState();
}

class _UploadAndEvaluatePageState extends State<UploadAndEvaluatePage> {
  String _status = 'No file uploaded yet';

  // ✅ Switch between LOCAL & PRODUCTION
  final String apiUrl = kDebugMode
      ? "http://localhost:3000/api/french-evaluate" // Local dev server
      : "https://your-deployed-french-api.netlify.app/api/french-evaluate"; // Deployed API

  Future<void> uploadPdfAndEvaluate() async {
    try {
      // Pick PDF file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result == null) {
        setState(() => _status = "No file selected.");
        return;
      }

      String fileName = result.files.single.name;
      Uint8List? fileBytes = result.files.single.bytes;

      if (fileBytes == null) {
        setState(() => _status = "Error: Could not read file.");
        return;
      }

      String base64String = base64Encode(fileBytes);

      setState(() => _status = "📤 Uploading $fileName to French API...");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'pdfBase64': base64String,
          'language': 'fr', // Pass language flag for French
        }),
      );

      if (response.statusCode == 200) {
        setState(() => _status = "✅ French Evaluation: ${response.body}");
      } else {
        setState(() => _status =
        "❌ Server error: ${response.statusCode} - ${response.body}");
      }
    } catch (e, stack) {
      debugPrint("❌ Error in uploadPdfAndEvaluate: $e");
      debugPrintStack(stackTrace: stack);
      if (mounted) {
        setState(() => _status = "Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Evaluator - French')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(_status, textAlign: TextAlign.center),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: uploadPdfAndEvaluate,
        icon: const Icon(Icons.upload_file),
        label: const Text("Upload PDF"),
      ),
    );
  }
}
