import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:virtualarch/screens/housemodels/exploremodels_screen.dart';

import '../../firebase/authentication.dart';
import '../../firebase/firestore_database.dart';
import '../../providers/user_data_provider.dart';
import '../../widgets/auth/custombuttontonext.dart';
import '../../widgets/customloadingspinner.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/customsnackbar.dart';
import '../../widgets/header.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});
  static const routeName = '/otp';

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otpController = "";
  Map<String, dynamic> errorIfAny = {};
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      // TODO: implement your code after email verification
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomSnackBar(
            messageToBePrinted: "Created account Successfully.",
            bgColor: Color.fromRGBO(44, 199, 142, 1),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );

      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var scaffoldMessengerVar = ScaffoldMessenger.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    var userProvider = Provider.of<UserDataProvide>(context, listen: false);
    var navigatorVar = Navigator.of(context);

    return Scaffold(
      body: MyCustomScreen(
        // customColor: Colors.blue,
        screenContent: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(heading: "OTP Verification"),
            SizedBox(
              height: size.height * 0.05,
            ),
            const Center(child: CustomLoadingSpinner()),
            SizedBox(
              height: size.height * 0.02,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.titleSmall,
                children: [
                  TextSpan(
                    text: "*",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: " Enter the OTP sent to ${args['email']}",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            NextButtonClass(
                text: "Verify OTP",
                onPressed: () async {
                  if (isEmailVerified) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CustomLoadingSpinner();
                      },
                    );
                    final User? user = Auth().currentUser;
                    await FireDatabase().createUser(
                      architectId: user!.uid.toString(),
                      architectData: args,
                    );
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ExploreModelsScreen();
                    }), (r) {
                      return false;
                    });
                  }

                  //Compare OTP: if correct createNewUser
                  // if (otpController == args['localOTP']) {
                  //   //Start CircularProgressIndicator
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return const CustomLoadingSpinner();
                  //     },
                  //   );

                  //Logic for authentication and create user
                  // errorIfAny = await Auth().createUserWithEmailAndPassword(
                  //   email: args['email'],
                  //   password: args['password'],
                  // );

                  //   if (errorIfAny.isEmpty) {

                  //     navigatorVar.pop();

                  //     scaffoldMessengerVar.showSnackBar(
                  //       const SnackBar(
                  //         content: CustomSnackBar(
                  //           messageToBePrinted: "Created account Successfully.",
                  //           bgColor: Color.fromRGBO(44, 199, 142, 1),
                  //         ),
                  //         behavior: SnackBarBehavior.floating,
                  //         backgroundColor: Colors.transparent,
                  //         elevation: 0,
                  //       ),
                  //     );
                  //     //Clears full stack fo screens.
                  //     // ignore: use_build_context_synchronously
                  //     Navigator.pushAndRemoveUntil(context,
                  //         MaterialPageRoute(builder: (BuildContext context) {
                  //       return ExploreModelsScreen();
                  //     }), (r) {
                  //       return false;
                  //     });
                  //   } else {
                  //     scaffoldMessengerVar.showSnackBar(
                  //       SnackBar(
                  //         content: CustomSnackBar(
                  //           messageToBePrinted: errorIfAny['error'],
                  //           bgColor: const Color.fromRGBO(199, 44, 65, 1),
                  //         ),
                  //         behavior: SnackBarBehavior.floating,
                  //         backgroundColor: Colors.transparent,
                  //         elevation: 0,
                  //       ),
                  //     );
                  //   }
                  //   //Logic for authentication ends here.
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: CustomSnackBar(
                  //         messageToBePrinted:
                  //             "Sorry, the OTP did not match. Please try again.",
                  //         bgColor: Color.fromRGBO(199, 44, 65, 1),
                  //       ),
                  //       behavior: SnackBarBehavior.floating,
                  //       backgroundColor: Colors.transparent,
                  //       elevation: 0,
                  //     ),
                  //   );
                  // }
                }),
          ],
        ),
      ),
    );
  }
}
