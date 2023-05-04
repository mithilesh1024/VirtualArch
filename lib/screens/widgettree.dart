//This page bascially checks if the person is already logged in or not
//On that basis it will decide whether it will route on displaypage or LoginPage.

import 'package:flutter/material.dart';
import 'package:virtualarch/screens/housemodels/exploremodels_screen.dart';
import '../firebase/authentication.dart';
import 'auth/login_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ExploreModelsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
