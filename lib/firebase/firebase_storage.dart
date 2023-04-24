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

  static List images = [null, null, null, null, null, null, null, null];

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static Future<dynamic> selectFile(int index) async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);
    if (result != null) {
      images[index] = result;
      //return result;
    }
    return null;
  }

  static Future<void> deleteModel(String url) async {
    storage.refFromURL(url).delete();
    FireDatabase.deleteFromDb(url);
  }

  static String getKey(int index) {
    switch (index) {
      case 0:
        return "Floor Plans";
      case 1:
        return "Elevations Plan";
      case 2:
        return "Site Plan";
      case 3:
        return "Foundational Plan";
      case 4:
        return "Electric Plan";
      case 5:
        return "Plumbing Plan";
      case 6:
        return "HVAC Plan";
      case 7:
        return "Other Plan";
      default:
        return "";
    }
  }

  static Future<void> uploadModel() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String location = "$userId/2d_images/";
    // final result = await selectFile();
    images.asMap().forEach((index, element) async {
      if (element != null) {
        String fileName = element.files.single.name;
        location += fileName;
        print(fileName);
        if (kIsWeb) {
          Uint8List uploadFile = element.files.single.bytes;
          final task = await storage.ref(location).putData(uploadFile);
          final urlString = await task.ref.getDownloadURL();
          FireDatabase.addModelUrl(urlString, getKey(index));
        } else {
          String filePath = element.files.single.path;
          File file = File(filePath);
          try {
            final task = await storage.ref(location).putFile(file);
            final urlString = await task.ref.getDownloadURL();
            FireDatabase.addModelUrl(urlString, getKey(index));
          } on firebase_core.FirebaseException catch (e) {
            print(e);
          }
        }
      }
    });
  }
}
