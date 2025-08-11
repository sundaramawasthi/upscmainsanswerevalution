import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/firebase storange.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  File? selectedFile;
  double uploadProgress = 0.0;
  bool isUploading = false;

  final TextEditingController questionIdController = TextEditingController();

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file first')),
      );
      return;
    }
    if (questionIdController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Question ID')),
      );
      return;
    }

    setState(() {
      isUploading = true;
      uploadProgress = 0.0;
    });

    try {
      // Upload file to Firebase Storage
      final fileUrl = await FirebaseStorageService.uploadFile(
        file: selectedFile!,
        onProgress: (progress) {
          setState(() {
            uploadProgress = progress;
          });
        },
      );

      // Save metadata to Firestore
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance.collection('answers').add({
        'userId': user.uid,
        'questionId': questionIdController.text.trim(),
        'fileUrl': fileUrl,
        'submittedAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File uploaded successfully!')),
      );

      // Clear form
      setState(() {
        selectedFile = null;
        questionIdController.clear();
        uploadProgress = 0.0;
        isUploading = false;
      });
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }

  @override
  void dispose() {
    questionIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Answer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: questionIdController,
              decoration: const InputDecoration(
                labelText: 'Question ID',
                hintText: 'Enter the question ID',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: isUploading ? null : pickFile,
              icon: const Icon(Icons.attach_file),
              label: const Text('Select File (PDF/Image)'),
            ),
            if (selectedFile != null) ...[
              const SizedBox(height: 10),
              Text('Selected: ${selectedFile!.path.split('/').last}'),
            ],
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: isUploading ? null : uploadFile,
              icon: const Icon(Icons.cloud_upload),
              label: Text(isUploading
                  ? 'Uploading ${ (uploadProgress * 100).toStringAsFixed(0) }%'
                  : 'Upload'),
            ),
            if (isUploading)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: LinearProgressIndicator(value: uploadProgress),
              ),
          ],
        ),
      ),
    );
  }
}
