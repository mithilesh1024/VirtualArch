import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../widgets/auth/custombuttontonext.dart';
import '../../widgets/auth/customdecorationforinput.dart';
import '../../widgets/customloadingspinner.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/customsnackbar.dart';
import 'package:http/http.dart' as http;

import '../../widgets/header.dart';
import 'otp_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});
  static const routeName = "/userInfo";

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _companyNameTextController = TextEditingController();
  final _archTypeTextController = TextEditingController();
  final _experienceTextController = TextEditingController();
  final _regNumberTextController = TextEditingController();
  final _skillsTextController = TextEditingController();
  final _streetAddressTextController = TextEditingController();
  final _cityTextController = TextEditingController();
  final _stateTextController = TextEditingController();
  final _zipNumTextController = TextEditingController();
  final _countryTextController = TextEditingController();

  String localOTP = "";

  Future<String> sendOtp(String userEmail) async {
    var url = Uri.http("10.0.2.2:5000", "/generate_otp/$userEmail");
    Response response = await http.get(url);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    var scaffoldMessengerVar = ScaffoldMessenger.of(context);
    var navigatorVar = Navigator.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: MyCustomScreen(
          // customColor: Colors.blue,
          screenContent: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(heading: "Personal Info"),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        //Row 1
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  enabled: false,
                                  decoration: customDecorationForInput(
                                    context,
                                    // args['email'],
                                    "chirag",
                                    Icons.email_rounded,
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _nameTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Name",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (name) {
                                    if (name != null && name.isEmpty) {
                                      return "Enter a valid name";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Row 2
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _archTypeTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Architect Type",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (type) {
                                    if (type != null && type.isEmpty) {
                                      return "Enter a valid Type";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _regNumberTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Register Number",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (regNum) {
                                    if (regNum != null && regNum.isEmpty) {
                                      return "Enter a valid Type";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Row 3
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _experienceTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Experience in Years",
                                    Icons.person_2_rounded,
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (years) {
                                    if (years != null && years.isEmpty) {
                                      return "Enter a valid years";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _skillsTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Relevant Skills",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (regNum) {
                                    if (regNum != null && regNum.isEmpty) {
                                      return "Enter a valid Type";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Row 4
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _companyNameTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Company Name",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (cname) {
                                    if (cname != null && cname.isEmpty) {
                                      return "Enter a valid Company name";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _streetAddressTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Office Street Address",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (address) {
                                    if (address != null && address.isEmpty) {
                                      return "Enter a valid Address";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Row 5
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _cityTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter City",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (cname) {
                                    if (cname != null && cname.isEmpty) {
                                      return "Enter a valid city name";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _stateTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter State",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (address) {
                                    if (address != null && address.isEmpty) {
                                      return "Enter a valid State";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Row 6
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _zipNumTextController,
                                  keyboardType: TextInputType.number,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Zip/Postal Code",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (cname) {
                                    if (cname != null && cname.isEmpty) {
                                      return "Enter a valid Zip Number";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: 500,
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _countryTextController,
                                  decoration: customDecorationForInput(
                                    context,
                                    "Enter Country",
                                    Icons.person_2_rounded,
                                  ),
                                  validator: (address) {
                                    if (address != null && address.isEmpty) {
                                      return "Enter a valid Country";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Text Tags
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              SizedBox(
                                width: 500,
                                child: TextFieldTags(
                                  textSeparators: const [
                                    " ", //seperate with space
                                    ',' //sepearate with comma as well
                                  ],
                                  initialTags: const [
                                    //inital tags
                                    'Architect',
                                    '3d models'
                                  ],
                                  onTag: (tag) {
                                    print(tag);
                                    //this will give tag when entered new single tag
                                  },
                                  onDelete: (tag) {
                                    print(tag);
                                    //this will give single tag on delete
                                  },
                                  validator: (tag) {
                                    //add validation for tags
                                    if (tag.length < 3) {
                                      return "Enter tag up to 3 characters.";
                                    }
                                    return null;
                                  },
                                  tagsStyler: TagsStyler(
                                    //styling tag style
                                    tagTextStyle:
                                        Theme.of(context).textTheme.titleSmall,
                                    tagDecoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    tagCancelIcon: Icon(Icons.cancel_outlined,
                                        size: 18.0,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor),
                                    tagPadding: const EdgeInsets.all(6.0),
                                  ),
                                  textFieldStyler: TextFieldStyler(
                                    //styling tag text field
                                    icon: Icon(
                                      Icons.workspace_premium_rounded,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                                    textFieldFocusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(98, 98, 98, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    textFieldBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    textFieldFilledColor:
                                        Theme.of(context).canvasColor,
                                    textFieldFilled: true,
                                    helperText: "",
                                    hintText: "Enter relevant skills",
                                    hintStyle:
                                        Theme.of(context).textTheme.titleSmall,
                                    helperStyle:
                                        Theme.of(context).textTheme.titleSmall,
                                    contentPadding: const EdgeInsets.all(24),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        NextButtonClass(
                          text: "Proceed to Verify",
                          onPressed: () async {
                            //Check for the fields are valid in TextFormField.
                            final isValid = formKey.currentState!.validate();
                            if (!isValid) return;

                            //Hides the keyboard.
                            FocusScope.of(context).unfocus();

                            //Start CircularProgressIndicator
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const CustomLoadingSpinner();
                              },
                            );

                            //Send OTP to the user
                            // localOTP = await sendOtp(args['email']);
                            localOTP = await sendOtp("chirag");

                            navigatorVar.pop();

                            if (localOTP != "") {
                              //Navigate to OTP Screen for verification.
                              scaffoldMessengerVar.showSnackBar(
                                const SnackBar(
                                  content: CustomSnackBar(
                                    messageToBePrinted: "OTP sent successfully",
                                    bgColor: Color.fromRGBO(44, 199, 142, 1),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                              );

                              navigatorVar.pushNamed(
                                OTPScreen.routeName,
                                arguments: {
                                  'email':
                                      "chiraggaonkar80@gmail.com", //args['email'],
                                  'password': "12345678", //args['password'],
                                  'name': _nameTextController.text,
                                  // 'phoneNumber': _phoneNumberController.text,
                                  // 'address': _addressController.text,
                                  'localOTP': localOTP,
                                },
                              );
                            } else {
                              scaffoldMessengerVar.showSnackBar(
                                const SnackBar(
                                  content: CustomSnackBar(
                                    messageToBePrinted: "Failed to send OTP",
                                    bgColor: Color.fromRGBO(199, 44, 65, 1),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
