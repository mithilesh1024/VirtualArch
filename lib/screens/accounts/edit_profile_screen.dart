import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualarch/screens/error_screen.dart';

import '../../providers/user_data_provider.dart';
import '../../widgets/accounts/customdecorationforaccountinput.dart';
import '../../widgets/auth/customdecorationforinput.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/headerwithnavigation.dart';
import '../housemodels/exploremodels_screen.dart';
import 'account_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const routeName = '/editProfile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _typeController = TextEditingController();
  final _cityController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _registerationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _aboutmeController = TextEditingController();
  final _skillsController = TextEditingController();
  final _imageController = TextEditingController();

  final _skillsKey = GlobalKey<FormFieldState<String>>();
  List<dynamic> _skills = [];

  var prefeb;
  bool init = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTextFormField(TextEditingController myController,
      TextInputType textType, String inputTextlabel, bool read) {
    return TextFormField(
      controller: myController,
      minLines: 1,
      maxLines: 2,
      keyboardType: textType,
      readOnly: read,
      decoration: customDecorationForAccountInput(
        context,
        inputTextlabel,
        Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user_data = Provider.of<UserDataProvide>(context, listen: false);
    bool isErrorOccured = false;
    try {
      final userData = ModalRoute.of(context)!.settings.arguments as Map;
      if (!init) {
        /*
        next_page_data["name"] = data.data["architectName"];
        next_page_data["type"] = data.data["architectType"];
        next_page_data["regNum"] = data.data["architectRegisterNum"];
        next_page_data["exp"] = data.data["architectExperience"];
        next_page_data["address"] = data.data["architectOfficeLocation"];
        next_page_data["aboutMe"] = data.data["aboutMe"];
        next_page_data["skills"] = data.data["skills"];
        next_page_data["image"] = data.data["architectImageUrl"];
        next_page_data["email"] = data.data["architectEmail"];
        */
        _nameController.text = userData["name"].toString();
        _emailTextController.text = userData["email"].toString();
        _typeController.text = userData["type"].toString();
        _registerationController.text = userData["regNum"].toString();
        _experienceController.text = userData["exp"].toString();
        _cityController.text = userData["address"]["city"].toString();
        _companyNameController.text =
            userData["address"]["companyName"].toString();
        _streetController.text =
            userData["address"]["companyStreetAddress"].toString();
        _countryController.text = userData["address"]["country"].toString();
        _stateController.text = userData["address"]["state"].toString();
        _zipcodeController.text = userData["address"]["zipCode"].toString();
        _aboutmeController.text = userData["aboutMe"].toString();
        _imageController.text = userData["image"].toString();
        _skillsController.text = "";
        _skills = userData["skills"] as List<dynamic>;
        init = true;
      }
      isErrorOccured = false;
    } catch (e) {
      isErrorOccured = true;
    }

    return isErrorOccured
        ? const ErrorScreen(
            screenToBeRendered: ExploreModelsScreen.routeName,
            renderScreenName: "Home Page")
        : Scaffold(
            // resizeToAvoidBottomInset: true,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: MyCustomScreen(
                customColor: Theme.of(context).primaryColor,
                screenContent: Column(
                  children: [
                    const HeaderWithNavigation(
                      heading: "Edit Profile",
                      screenToBeRendered: "", // change afterwards
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            const CircleAvatar(
                              backgroundImage: AssetImage("assets/Female.png"),
                              radius: 80,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(
                              _emailTextController,
                              TextInputType.name,
                              "Email",
                              true,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(
                              _registerationController,
                              TextInputType.name,
                              "Registeration Number",
                              true,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(
                              _nameController,
                              TextInputType.name,
                              "Name",
                              false,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_aboutmeController,
                                TextInputType.name, "About Me", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(
                                _typeController,
                                TextInputType.multiline,
                                "Architect Type",
                                true),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_experienceController,
                                TextInputType.number, "Experience", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_cityController,
                                TextInputType.name, "City", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_companyNameController,
                                TextInputType.name, "Company Name", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_streetController,
                                TextInputType.name, "Street", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_countryController,
                                TextInputType.name, "Country", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_stateController,
                                TextInputType.name, "State", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_zipcodeController,
                                TextInputType.number, "Zip Code", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //TextFormField
                            _buildTextFormField(_imageController,
                                TextInputType.name, "Image Url", false),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            TextFormField(
                              key: _skillsKey,
                              controller: _skillsController,
                              keyboardType: TextInputType.number,
                              maxLength: 15,
                              decoration: customDecorationForInput(
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
                                _skillsKey.currentState!.validate();
                                setState(() {
                                  if (!_skills.contains(value)) {
                                    _skills.add(value);
                                  }
                                  _skillsController.text = "";
                                });
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, 0, 0, size.height * 0.07),
                              child: ElevatedButton(
                                onPressed: () {
                                  Map<String, String> data = {
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
                                  };
                                  // print(_nameController.text);
                                  // print(_emailTextController.text);
                                  // print(_phoneNoController.text);
                                  // print(_addressController.text);
                                  user_data.updateData(data);
                                  Navigator.pushNamed(
                                      context, AccountScreen.routeName,
                                      arguments: {"reload": true});
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                    size.width * 0.8,
                                    size.height * 0.06,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  "Save",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            )
                          ],
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
