import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'firestore_database.dart';

class FirebaseStorage {
  static final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

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

  static Future<void> deleteModel(String url) async {
    storage.refFromURL(url).delete();
    FireDatabase.deleteFromDb(url);
  }

  static Future<void> uploadModel() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String location = "$userId/2d_images/${getRandomString(10)}";
    final result = await selectFile();
    if (result != null) {
      String fileName = result.files.single.name;
      if (kIsWeb) {
        Uint8List uploadFile = result.files.single.bytes;
        final task = await storage.ref(location).putData(uploadFile);
        final urlString = await task.ref.getDownloadURL();
        FireDatabase.addModelUrl(urlString);
      } else {
        String filePath = result.files.single.path;
        File file = File(filePath);
        try {
          final task = await storage.ref(location).putFile(file);
          final urlString = await task.ref.getDownloadURL();
          FireDatabase.addModelUrl(urlString);
        } on firebase_core.FirebaseException catch (e) {
          print(e);
        }
      }
    }
  }
}
