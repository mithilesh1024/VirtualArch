import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseStorage {
  static final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<dynamic> selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);
    if (result != null) {
      return result;
    }
    return null;
  }

  static Future<void> uploadModel() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final result = await selectFile();
    if (result != null) {
      String fileName = result.files.single.name;
      if (kIsWeb) {
        Uint8List uploadFile = result.files.single.bytes;
        await storage.ref("$userId/$fileName").putData(uploadFile);
      } else {
        String filePath = result.files.single.path;
        File file = File(filePath);
        try {
          await storage.ref("$userId/$fileName").putFile(file);
        } on firebase_core.FirebaseException catch (e) {
          print(e);
        }
      }
    }
  }
}
