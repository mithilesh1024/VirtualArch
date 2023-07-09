import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvide with ChangeNotifier {
  String name = "";
  String email = "";
  String address = "";
  String number = "";
  Map<String, dynamic> data = {
    "name": "",
    "email": "",
    "address": "",
    "phoneNumber": ""
  };

  Future<Map<String, dynamic>> getData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('architects')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        data = await documentSnapshot.data() as Map<String, dynamic>;
        extractData();
      }
    });
    return data;
  }

  void extractData() async {
    final prefeb = await SharedPreferences.getInstance();
    name = data["name"];
    await prefeb.setString('name', name);
    address = data["address"];
    await prefeb.setString('address', address);
    number = data["phoneNumber"];
    await prefeb.setString('phoneNumber', number);
    email = data["email"];
    await prefeb.setString('email', email);
  }

  Future<void> updateData(Map<String, String> data) async {
    /*
      "name": _nameController.text,
      "exp": _experienceController.text,
      "city": _cityController.text,
      "company": _companyNameController.text,
      "street": _streetController.text,
      "country": _countryController.text,
      "state": _stateController.text,
      "zip": _zipcodeController.text,
      "aboutMe": _aboutmeController.text,
      "image": _imageController.text,                 
     */
    final userId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, String> address = {
      "city": data["city"].toString(),
      "companyName": data["company"].toString(),
      "companyStreetAddress": data["street"].toString(),
      "country": data["country"].toString(),
      "state": data["state"].toString(),
      "zipCode": data["zip"].toString()
    };
    FirebaseFirestore.instance.collection('architects').doc(userId).update({
      "architectName": data["name"],
      "aboutMe": data["aboutMe"],
      "architectExperience": data["exp"],
      "architectImageUrl": data["image"],
      "architectOfficeLocation": address,
    });
  }
}
