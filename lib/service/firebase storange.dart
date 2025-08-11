import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<String> uploadFile({
    required File file,
    required void Function(double progress) onProgress,
  }) async {
    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split('/').last;
    final fileRef = storageRef.child('uploads/$fileName');

    final uploadTask = fileRef.putFile(file);

    uploadTask.snapshotEvents.listen((event) {
      final progress = event.bytesTransferred / event.totalBytes;
      onProgress(progress);
    });

    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
