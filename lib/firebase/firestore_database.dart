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
}
