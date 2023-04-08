import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
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
  final _nameKey = GlobalKey<FormFieldState<String>>();
  final _archTypeKey = GlobalKey<FormFieldState<String>>();
  final _regNumKey = GlobalKey<FormFieldState<String>>();
  final _expKey = GlobalKey<FormFieldState<String>>();
  final _companyNameKey = GlobalKey<FormFieldState<String>>();
  final _streetaddKey = GlobalKey<FormFieldState<String>>();
  final _cityKey = GlobalKey<FormFieldState<String>>();
  final _stateKey = GlobalKey<FormFieldState<String>>();
  final _zipcodeKey = GlobalKey<FormFieldState<String>>();
  final _countryKey = GlobalKey<FormFieldState<String>>();
  final _aboutMeKey = GlobalKey<FormFieldState<String>>();
  final _skillsKey = GlobalKey<FormFieldState<String>>();

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
  final _aboutMeTextController = TextEditingController();

  final List<String> _skills = [];

  String localOTP = "";

  Future<String> sendOtp(String userEmail) async {
    var url = Uri.http("10.0.2.2:5000", "/generate_otp/$userEmail");
    Response response = await http.get(url);
    return response.body;
  }

  int currentStep = 0;
  continueStep() {
    if (currentStep < 2) {
      //Check for the fields are valid in TextFormField.
      if (currentStep == 0 &&
          _nameKey.currentState!.validate() &&
          _archTypeKey.currentState!.validate() &&
          _regNumKey.currentState!.validate() &&
          _expKey.currentState!.validate()) {
        setState(() {
          currentStep = 1;
          print(currentStep);
        });
      } else if (currentStep == 1 &&
          _companyNameKey.currentState!.validate() &&
          _streetaddKey.currentState!.validate() &&
          _cityKey.currentState!.validate() &&
          _stateKey.currentState!.validate() &&
          _zipcodeKey.currentState!.validate() &&
          _countryKey.currentState!.validate()) {
        setState(() {
          currentStep = 2;
          print(currentStep);
        });
      }
    } else {
      _aboutMeKey.currentState!.validate();
      _skillsKey.currentState!.validate();
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  Widget controlsBuilder(context, details) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: const Text('Continue'),
            ),
            const SizedBox(
              width: 10,
            ),
            OutlinedButton(
              onPressed: details.onStepCancel,
              child: const Text('Back'),
            )
          ],
        ),
      ),
    );
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
                        Stepper(
                          currentStep: currentStep,
                          onStepContinue: continueStep,
                          onStepCancel: cancelStep,
                          controlsBuilder: controlsBuilder,
                          steps: [
                            Step(
                              isActive: currentStep >= 0,
                              title: Text(
                                "Personal Information",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              content: Column(
                                children: [
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
                                            decoration:
                                                customDecorationForInput(
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
                                            key: _nameKey,
                                            controller: _nameTextController,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Enter Name",
                                              Icons.person_2_rounded,
                                            ),
                                            validator: (name) {
                                              if (name != null &&
                                                  name.isEmpty) {
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
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Container(
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            key: _archTypeKey,
                                            controller: _archTypeTextController,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Enter Architect Type",
                                              Icons.account_tree_rounded,
                                            ),
                                            validator: (type) {
                                              if (type != null &&
                                                  type.isEmpty) {
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
                                            key: _regNumKey,
                                            controller:
                                                _regNumberTextController,
                                            decoration:
                                                customDecorationForInput(
                                                    context,
                                                    "Enter Register Number",
                                                    Icons.verified_outlined),
                                            validator: (regNum) {
                                              if (regNum != null &&
                                                  regNum.isEmpty) {
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
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Container(
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            key: _expKey,
                                            controller:
                                                _experienceTextController,
                                            decoration: customDecorationForInput(
                                                context,
                                                "Enter Experience in Years",
                                                Icons
                                                    .real_estate_agent_rounded),
                                            keyboardType: TextInputType.number,
                                            validator: (years) {
                                              if (years != null &&
                                                  years.isEmpty) {
                                                return "Enter a valid years";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Step(
                              isActive: currentStep >= 1,
                              title: Text(
                                "Office Information",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              content: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Container(
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            key: _companyNameKey,
                                            controller:
                                                _companyNameTextController,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Enter Company Name",
                                              Icons.share_location_sharp,
                                            ),
                                            validator: (cname) {
                                              if (cname != null &&
                                                  cname.isEmpty) {
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
                                            key: _streetaddKey,
                                            controller:
                                                _streetAddressTextController,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Enter Office Street Address",
                                              Icons.share_location_sharp,
                                            ),
                                            validator: (address) {
                                              if (address != null &&
                                                  address.isEmpty) {
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
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Container(
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            key: _cityKey,
                                            controller: _cityTextController,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Enter City",
                                              Icons.share_location_sharp,
                                            ),
                                            validator: (cname) {
                                              if (cname != null &&
                                                  cname.isEmpty) {
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
                                            key: _stateKey,
                                            controller: _stateTextController,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Enter State",
                                              Icons.share_location_sharp,
                                            ),
                                            validator: (address) {
                                              if (address != null &&
                                                  address.isEmpty) {
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
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Container(
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            key: _zipcodeKey,
                                            controller: _zipNumTextController,
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Enter Zip/Postal Code",
                                              Icons.share_location_sharp,
                                            ),
                                            validator: (cname) {
                                              if (cname != null &&
                                                  cname.isEmpty) {
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
                                            key: _countryKey,
                                            controller: _countryTextController,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Enter Country",
                                              Icons.share_location_sharp,
                                            ),
                                            validator: (address) {
                                              if (address != null &&
                                                  address.isEmpty) {
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
                                ],
                              ),
                            ),
                            Step(
                              isActive: currentStep >= 2,
                              title: Text(
                                'More about yourself',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              content: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Container(
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            key: _aboutMeKey,
                                            controller: _aboutMeTextController,
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                customDecorationForInput(
                                              context,
                                              "Tell us something about yourself",
                                              Icons.catching_pokemon,
                                            ),
                                            minLines: 1,
                                            maxLines: 10,
                                            validator: (about) {
                                              if (about != null &&
                                                  about.isEmpty) {
                                                return "Please add some content";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 500,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: _skills.isNotEmpty
                                                ? Theme.of(context).canvasColor
                                                : Colors.transparent,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextFormField(
                                                key: _skillsKey,
                                                controller:
                                                    _skillsTextController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    customDecorationForInput(
                                                  context,
                                                  "Add Skills",
                                                  Icons.add_moderator_outlined,
                                                ),
                                                validator: (about) {
                                                  if (_skills.isEmpty) {
                                                    return "Please add atleast 1 skill";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onFieldSubmitted: (value) {
                                                  setState(() {
                                                    if (!_skills
                                                        .contains(value)) {
                                                      _skills.add(value);
                                                    }
                                                    _skillsTextController.text =
                                                        "";
                                                  });
                                                },
                                              ),
                                              if (_skills.isNotEmpty)
                                                ResponsiveGridList(
                                                  minItemWidth: 100,
                                                  shrinkWrap: true,
                                                  children: List.generate(
                                                    _skills.length,
                                                    (index) => Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _skills.remove(
                                                                _skills[index]);
                                                          });
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            _skills[index],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.width * 0.02,
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
