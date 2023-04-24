import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtualarch/firebase/architects_model.dart';

class FireDatabase {
  Future<void> createUser({
    required String architectId,
    required Map architectData,
  }) async {
    try {
      final docArchitect =
          FirebaseFirestore.instance.collection("architects").doc(architectId);
      final architect = ArchitectModel(
        architectID: architectId,
        architectName: architectData['architectName'],
        architectType: architectData['architectType'],
        architectRegisterNum: architectData['architectRegisterNum'],
        architectExperience: architectData['architectExperience'],
        architectOfficeLocation: {
          'companyName': architectData['architectCompanyName'],
          'companyStreetAddress': architectData['architectStreetAddress'],
          'city': architectData['architectCity'],
          'state': architectData['architectState'],
          'zipCode': architectData['architectZipCode'],
          'country': architectData['architectCountry'],
        },
        aboutMe: architectData['architectAboutMe'],
        skills: architectData['architectSkills'],
      );
      final json = architect.toJson();
      await docArchitect.set(json);
    } on FirebaseException catch (e) {
      print("Error ${e}");
    }
  }

  static Future<void> addModelUrl(String url, String key) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    print("field ${key} url ${url}");
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('models').doc(userId).get();
    print("exist or not ${ds.exists}");
    // if (ds.exists) {
    // var map = {
    //   "house1": {
    //     "2d_images": FieldValue.arrayUnion([url])
    //   }
    // };
    // await FirebaseFirestore.instance.collection('models').doc(userId).update({
    //   "house1": {
    //     "2d_images": FieldValue.array([url])
    //   }
    // }).then((value) {
    //   print("updated");
    // });
    // } else {
    // var map = {
    //   "house1": {key: url}
    // };
    await FirebaseFirestore.instance.collection('models').doc(userId).set({
      "house1": {key: url}
    }, SetOptions(merge: true));
    // }
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
