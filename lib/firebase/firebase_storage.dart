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

  static List model = [null, null];
  static var sample_image = null;

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static Future<dynamic> select3DModel(int index) async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['glb']);
    if (result != null) {
      model[index] = result;
    }
    return null;
  }

  static Future<List<String>> upload3DModel() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    List<String> combinedUrl = [];
    String location = "/3d_images/";
    var urlString = "";
    for (int i = 0; i < model.length; i++) {
      if (model != null) {
        String fileName = model[i].files.single.name;
        location += fileName;
        print(fileName);
        if (kIsWeb) {
          Uint8List uploadFile = model[i].files.single.bytes;
          final task = await storage.ref(location).putData(uploadFile);
          urlString = await task.ref.getDownloadURL();
          print("key 3dModel \nurl $urlString");
          // await FireDatabase.addModelUrl(urlString, "3dModel", id);
        } else {
          String filePath = model[i].files.single.path;
          File file = File(filePath);
          try {
            final task = await storage.ref(location).putFile(file);
            final urlString = await task.ref.getDownloadURL();
            // await FireDatabase.addModelUrl(urlString, "3dModel", id);
          } on firebase_core.FirebaseException catch (e) {
            print(e);
          }
        }
        combinedUrl.add(urlString);
      }
    }
    return combinedUrl;
  }

  static Future<dynamic> selectSampleFile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);
    if (result != null) {
      sample_image = result;
    }
    return null;
  }

  static Future<String> uploadSampleImage() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String location = "/2d_images/";
    var urlString = "";
    if (sample_image != null) {
      String fileName = sample_image.files.single.name;
      location += fileName;
      print(fileName);
      if (kIsWeb) {
        Uint8List uploadFile = sample_image.files.single.bytes;
        final task = await storage.ref(location).putData(uploadFile);
        urlString = await task.ref.getDownloadURL();
        print("key image \nurl $urlString");
        //await FireDatabase.addModelUrl(urlString, "Sample_image", id);
      } else {
        String filePath = sample_image.files.single.path;
        File file = File(filePath);
        try {
          final task = await storage.ref(location).putFile(file);
          final urlString = await task.ref.getDownloadURL();
          //await FireDatabase.addModelUrl(urlString, "Sample_image", id);
        } on firebase_core.FirebaseException catch (e) {
          print(e);
        }
      }
    }
    return urlString;
  }

  static Future<dynamic> selectFile(int index) async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);
    if (result != null) {
      images[index] = result;
    }
    return null;
  }

  static String getKey(int index) {
    switch (index) {
      case 0:
        return "Floor Plan";
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
        return "Other Plan";
      default:
        return "";
    }
  }

  static Future<void> uploadModel(String id) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String location = "$id/2d_images/";
    images.asMap().forEach(
      (index, element) async {
        if (element != null) {
          String fileName = element.files.single.name;
          location += fileName;
          print(fileName);
          if (kIsWeb) {
            Uint8List uploadFile = element.files.single.bytes;
            final task = await storage.ref(location).putData(uploadFile);
            final urlString = await task.ref.getDownloadURL();
            print("key ${getKey(index)} \nurl $urlString");
            await FireDatabase.addModelUrl(urlString, getKey(index), id);
          } else {
            String filePath = element.files.single.path;
            File file = File(filePath);
            try {
              final task = await storage.ref(location).putFile(file);
              final urlString = await task.ref.getDownloadURL();
              await FireDatabase.addModelUrl(urlString, getKey(index), id);
            } on firebase_core.FirebaseException catch (e) {
              print(e);
            }
          }
        }
      },
    );
  }

  static Future<void> deleteModel(String url) async {
    storage.refFromURL(url).delete();
    FireDatabase.deleteFromDb(url);
  }
}
