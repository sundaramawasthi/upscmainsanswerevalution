import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  // Catch Flutter framework-level errors
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('🔴 Flutter Error: ${details.exceptionAsString()}');
    debugPrintStack(stackTrace: details.stack);
  };

  // Catch uncaught async/sync errors
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
      title: 'PDF Evaluator',
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

  Future<void> uploadPdfAndEvaluate() async {
    try {
      // Pick PDF file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true, // Ensures file bytes are loaded for both web & mobile
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

      // Convert file to Base64
      String base64String = base64Encode(fileBytes);

      setState(() => _status = "📤 Uploading $fileName...");

      // Send POST request
      var url = Uri.parse("http://localhost:3000/api/evaluate"); // Change to deployed API URL
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'pdfBase64': base64String}),
      );

      if (response.statusCode == 200) {
        setState(() => _status = "✅ Evaluation complete: ${response.body}");
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
      appBar: AppBar(title: const Text('PDF Evaluator')),
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
