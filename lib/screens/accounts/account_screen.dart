import 'package:flutter/material.dart';
import 'package:googleapis/compute/v1.dart';
import 'package:provider/provider.dart';
import 'package:virtualarch/screens/auth/home_screen.dart';
import 'package:virtualarch/screens/housemodels/exploremodels_screen.dart';
import '../../firebase/firebase_storage.dart';
import '../../providers/user_data_provider.dart';
import '../../widgets/accounts/customdecorationforaccountinput.dart';
import '../../widgets/customloadingspinner.dart';
import '../../widgets/custommenu.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/headerwithmenu.dart';
import '../error_screen.dart';
import 'edit_profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static const routeName = '/account';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with WidgetsBindingObserver {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _addressController = "";
  var prefeb;
  String name = "";
  Map<String, dynamic> next_page_data = {};

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTheNavigation(String heading, Future<Object?> navigator) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          onPressed: () => navigator,
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField(
    String inputText,
    String infoText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.catching_pokemon,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              infoText,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        Container(
          // width: 200,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: Theme.of(context).canvasColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(inputText, style: Theme.of(context).textTheme.titleSmall),
        )
      ],
    );
  }

  void add_data(AsyncSnapshot<dynamic> data) {
    next_page_data["name"] = data.data["architectName"];
    next_page_data["type"] = data.data["architectType"];
    next_page_data["regNum"] = data.data["architectRegisterNum"];
    next_page_data["exp"] = data.data["architectExperience"];
    next_page_data["address"] = data.data["architectOfficeLocation"];
    next_page_data["aboutMe"] = data.data["aboutMe"];
    next_page_data["skills"] = data.data["skills"];
    next_page_data["image"] = data.data["architectImageUrl"];
    next_page_data["email"] = data.data["architectEmail"];
    print("\nabout me\n");
    print(data.data["skills"]);
  }

  @override
  Widget build(BuildContext context) {
    bool isErrorOccured = false;
    try {
      final reload = ModalRoute.of(context)!.settings.arguments as Map;
      if (reload["reload"] == true) {
        setState(() {});
      }
      isErrorOccured = false;
    } catch (e) {
      isErrorOccured = true;
    }

    var size = MediaQuery.of(context).size;
    var user_data = Provider.of<UserDataProvide>(context, listen: false);
    return isErrorOccured
        ? const ErrorScreen(
            screenToBeRendered: ExploreModelsScreen.routeName,
            renderScreenName: "Home Page")
        : Scaffold(
            key: scaffoldKey,
            endDrawer: const CustomMenu(),
            body: MyCustomScreen(
              customColor: Theme.of(context).primaryColor,
              screenContent: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeaderWithMenu(
                    header: "My Account",
                    scaffoldKey: scaffoldKey,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            // crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              Column(
                                children: [
                                  FutureBuilder(
                                    future: user_data.getData(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        String name =
                                            snapshot.data["architectName"];
                                        String email =
                                            snapshot.data["architectEmail"];
                                        var tempAddr = snapshot
                                            .data["architectOfficeLocation"];
                                        _addressController =
                                            tempAddr["companyStreetAddress"] +
                                                " " +
                                                tempAddr["city"] +
                                                " " +
                                                tempAddr["state"] +
                                                " " +
                                                tempAddr["zipCode"];
                                        add_data(snapshot);
                                        //print(" adress ${_addressController.text}");
                                        //_phoneNoController.text = snapshot.data["phoneNumber"];
                                        return Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .canvasColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: 500,
                                                  child: Column(children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "My Profile",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await FirebaseStorage
                                                            .uploadDP();
                                                        setState(() {});
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(snapshot
                                                                    .data[
                                                                "architectImageUrl"]),
                                                        radius: 80,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Text(
                                                      name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall,
                                                    ),
                                                    Text(
                                                      email,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                  ]),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                  width: size.width * 0.02,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .canvasColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: 500,
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "About Me",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data["aboutMe"],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.02,
                                              width: size.width * 0.02,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .canvasColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: 500,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "Personal Info",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                        ),
                                                      ),
                                                      _buildTextFormField(
                                                          snapshot.data[
                                                              "architectRegisterNum"],
                                                          "Registration Number"),
                                                      _buildTextFormField(
                                                          snapshot.data[
                                                              "architectType"],
                                                          "Architect Type"),
                                                      _buildTextFormField(
                                                          "${snapshot.data["architectExperience"]} years",
                                                          "Experience"),
                                                      _buildTextFormField(
                                                          snapshot
                                                              .data["skills"]
                                                              .toString()
                                                              .substring(
                                                                1,
                                                                snapshot.data[
                                                                            "skills"]
                                                                        .toString()
                                                                        .length -
                                                                    1,
                                                              ),
                                                          "Skills"),
                                                      _buildTextFormField(
                                                          tempAddr[
                                                              "companyName"],
                                                          "Company Name"),
                                                      _buildTextFormField(
                                                          _addressController,
                                                          "Address"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                  width: size.width * 0.02,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .canvasColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: 500,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Edit Profile",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () => Navigator
                                                                .of(context)
                                                            .pushNamed(
                                                                EditProfileScreen
                                                                    .routeName,
                                                                arguments:
                                                                    next_page_data),
                                                        icon: const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const CustomLoadingSpinner();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
