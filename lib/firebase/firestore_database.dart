import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/users_model.dart';

class FireDatabase {
  Future<void> createUser({
    required String uid,
    required String name,
    required String phoneNumber,
    required String email,
    required String address,
  }) async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection("architects").doc(uid);
      final user = UserModel(
        uid: uid,
        name: name,
        address: address,
        email: email,
        phoneNumber: phoneNumber,
      );
      final json = user.toJson();
      await docUser.set(json);
    } on FirebaseException catch (e) {
      print("Error ${e}");
    }
  }

  static Future<void> addModelUrl(String url) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('models').doc(userId).update({
      "house1": {
        "2d_images": FieldValue.arrayUnion([url])
      }
    });
  }

  static Future<void> deleteFromDb(String url) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('models').doc(userId).update({
      "house1": {
        "2d_images": FieldValue.arrayRemove([url])
      }
    });
  }
}
