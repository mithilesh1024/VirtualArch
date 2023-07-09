import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:virtualarch/firebase/firebase_uploads.dart';
import 'package:virtualarch/screens/error_screen.dart';
import 'package:virtualarch/screens/housemodels/exploremodels_screen.dart';
import 'package:virtualarch/widgets/upload_work/upload_image.dart';
import '../../firebase/firebase_storage.dart';
import '../../widgets/customloadingspinner.dart';
import '../../widgets/custommenu.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/headerwithmenu.dart';
import '../../widgets/upload_work/add_design_button.dart';
import '../../widgets/auth/customdecorationforinput.dart';

class UploadDesignScreen extends StatefulWidget {
  const UploadDesignScreen({super.key});
  @override
  State<UploadDesignScreen> createState() => _UploadDesignScreenState();
  static const routeName = '/uploadDesign';
}

class _UploadDesignScreenState extends State<UploadDesignScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  List<String> imageLinks = [];
  List<TextEditingController> controllers = [];
  List<GlobalKey<FormState>> keys = [];
  bool isErrorOccured = false;

  Widget textInputBuilder(
    Key inputKey,
    String inputTitle,
    IconData inputIcon,
    TextEditingController inputs,
  ) {
    return Container(
      width: 500,
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        key: inputKey,
        controller: inputs,
        decoration: customDecorationForInput(
          context,
          inputTitle,
          inputIcon,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Name your Design";
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //Try Catch Starts
    String projectId = "";
    try {
      isErrorOccured = false;
      projectId = ModalRoute.of(context)!.settings.arguments as String;
    } catch (e) {
      isErrorOccured = true;
    }
    //Try catch ends

    if (controllers.length == 0) {
      controllers.add(TextEditingController());
    }
    if (keys.length == 0) {
      keys.add(GlobalKey<FormState>());
    }
    return isErrorOccured
        ? const ErrorScreen(
            screenToBeRendered: ExploreModelsScreen.routeName,
            renderScreenName: "Explore Models",
          )
        : ScaffoldMessenger(
            child: Scaffold(
              key: scaffoldKey,
              endDrawer: const CustomMenu(),
              body: MyCustomScreen(
                // customColor: Colors.blue,
                screenContent: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWithMenu(
                        header: "Upload Designs",
                        scaffoldKey: scaffoldKey,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              alignment: WrapAlignment.spaceAround,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height,
                                  child: ResponsiveGridList(
                                    rowMainAxisAlignment: MainAxisAlignment.end,
                                    minItemsPerRow: 1,
                                    minItemWidth: 250,
                                    listViewBuilderOptions:
                                        ListViewBuilderOptions(
                                      padding: EdgeInsets.zero,
                                    ),
                                    children: List.generate(
                                        imageLinks.length,
                                        (index) => Column(
                                              children: [
                                                UploadImage(
                                                  imgName: "Design $index",
                                                  index: index,
                                                  onPressed: () async {
                                                    await FirebaseStorage
                                                        .selectFile(index);
                                                    setState(() {});
                                                  },
                                                ),
                                                textInputBuilder(
                                                  keys[index],
                                                  "What type of plan it is?",
                                                  Icons.travel_explore_outlined,
                                                  controllers[index],
                                                ),
                                              ],
                                            )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Demo of using 2 diff ways of Tooltip
                  Tooltip(
                    message: "Upload Plans",
                    preferBelow: false,
                    child: FloatingActionButton(
                      onPressed: () async {
                        final isValid = _formKey.currentState!.validate();
                        if (!isValid) {
                          return;
                        }
                        //Start CircularProgressIndicator
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomLoadingSpinner();
                          },
                        );

                        Map<String, String> uploadedData =
                            await FirebaseStorage.uploadModel(controllers);
                        if (uploadedData.isNotEmpty) {
                          bool isUploadSucess =
                              await FirebaseUploads().addOtherDesignLinks(
                            modelOtherDesignLinks: uploadedData,
                            projectId: projectId,
                          );

                          if (isUploadSucess) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AwesomeSnackbarContent(
                                    title: 'Hurray!',
                                    message:
                                        "Project Designs was successfully Uploaded.",
                                    contentType: ContentType.success,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                              );
                            });
                          } else {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AwesomeSnackbarContent(
                                    title: 'Oh snap!',
                                    message: "Unable to upload Designs.",
                                    contentType: ContentType.failure,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                              );
                            });
                          }
                        }
                        // print(uploadedData[controllers[0].text]);
                        // print("uploaded");

                        // / End CircularProgressIndicator
                        Navigator.of(context).pop();

                        Navigator.of(context).popAndPushNamed(
                          ExploreModelsScreen.routeName,
                        );
                      },
                      heroTag: null,
                      child: const Icon(Icons.cloud_upload_outlined),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: () {
                      //add
                      setState(() {
                        FirebaseStorage.updateImageList();
                        imageLinks.add("Added");
                        controllers.add(TextEditingController());
                        keys.add(GlobalKey<FormState>());
                      });
                    },
                    tooltip: "Add Plans",
                    heroTag: null,
                    backgroundColor: Theme.of(context).canvasColor,
                    child: const AddButtonDesign(),
                  ),
                ],
              ),
            ),
          );
  }
}
