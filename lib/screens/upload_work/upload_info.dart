import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:virtualarch/firebase/firebase_uploads.dart';
import 'package:virtualarch/screens/housemodels/exploremodels_screen.dart';
import 'package:virtualarch/screens/upload_work/upload_work.dart';
import 'package:virtualarch/widgets/headerwithmenu.dart';
import 'package:virtualarch/widgets/upload_work/upload_image.dart';
import '../../firebase/authentication.dart';
import '../../firebase/firebase_storage.dart';
import '../../providers/feature_options_provider.dart';
import '../../widgets/auth/customdecorationforinput.dart';
import '../../widgets/customloadingspinner.dart';
import '../../widgets/custommenu.dart';
import '../../widgets/customscreen.dart';

class UploadProjInfo extends StatefulWidget {
  const UploadProjInfo({super.key});
  static const routeName = "/uploadWork";

  @override
  State<UploadProjInfo> createState() => _UploadProjInfoState();
}

class _UploadProjInfoState extends State<UploadProjInfo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final _modelNameKey = GlobalKey<FormFieldState<String>>();
  final _modelPriceKey = GlobalKey<FormFieldState<String>>();
  final _modelEstimatedBuildPriceKey = GlobalKey<FormFieldState<String>>();
  final _modelFloorsKey = GlobalKey<FormFieldState<String>>();
  final _modelTotalSquareFootageKey = GlobalKey<FormFieldState<String>>();
  final _modelNumberOfCommonRoomsKey = GlobalKey<FormFieldState<String>>();
  final _modelNumberOfBedroomsKey = GlobalKey<FormFieldState<String>>();
  final _modelNumberOfBathsKey = GlobalKey<FormFieldState<String>>();
  final _modelCeilingHeightKey = GlobalKey<FormFieldState<String>>();

  int currentStep = 0;

  //Controllers
  //General
  final _modelNameController = TextEditingController();
  final _modelPriceController = TextEditingController();
  final _modelEstimatedBuildPriceController = TextEditingController();

  //Exterior
  final List _modelColorSchemeController = [];
  final _modelFloorsController = TextEditingController();
  final _modelTotalSquareFootageController = TextEditingController();
  final List _modelRoofStyleController = [];

  //Interior
  final _modelNumberOfCommonRoomsController = TextEditingController();
  final _modelNumberOfBedroomsController = TextEditingController();
  final _modelNumberOfBathsController = TextEditingController();
  final _modelCeilingHeightController = TextEditingController();
  final List _modelFlooringOfRoomsController = [];
  final List _modelLightingOfRoomsController = [];

  //Kitchen & Bathrooms
  final List _modelKitchenCountertopsController = [];
  final List _modelKitchenCabinetryController = [];
  final List _modelFlooringOfKitchenController = [];
  final List _modelBathroomVanityController = [];

  //Outdoor Space
  bool _modelYardController = false;
  bool _modelDeckController = false;
  bool _modelPatioController = false;
  bool _modelPoolController = false;
  bool _modelParkingsController = false;

  //Technology and smart features
  final List _modelTechnologyAndSmartFeaturesController = [];

  //Important urls
  String _model3dURLController = "";
  String _modelImageURLController = "";
  String _model3dBirdsView = "";

  continueStep() async {
    bool isLastStep = (currentStep == 6);
    if (isLastStep) {
      //Hides the keyboard.
      FocusScope.of(context).unfocus();

      //Start CircularProgressIndicator
      showDialog(
        context: context,
        builder: (context) {
          return const CustomLoadingSpinner();
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Alert!',
            message: "Uploading may take few minutes.",
            contentType: ContentType.warning,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );

      final User? user = Auth().currentUser;

      _modelImageURLController = await FirebaseStorage.uploadSampleImage();
      dynamic temp = await FirebaseStorage.upload3DModel();
      _model3dURLController = temp[0];
      _model3dBirdsView = temp[1];

      final architectName = await Auth().getArchitectName();

      Map<String, dynamic> projectInfo = {
        'modelImageURL': _modelImageURLController,
        'model3dURL': _model3dURLController,
        'model3dBirdsView': _model3dBirdsView,
        'modelName': _modelNameController.text,
        'modelPrice': _modelPriceController.text,
        'modelEstimatedBuildPrice': _modelEstimatedBuildPriceController.text,
        'modelArchitectname': architectName,
        'modelArchitectID': user!.uid,
        'modelColorScheme': _modelColorSchemeController,
        'modelFloors': _modelFloorsController.text,
        'modelTotalSquareFootage': _modelTotalSquareFootageController.text,
        'modelRoofStyle': _modelRoofStyleController,
        'modelNumberOfCommonRooms': _modelNumberOfCommonRoomsController.text,
        'modelNumberOfBedrooms': _modelNumberOfBedroomsController.text,
        'modelNumberOfBaths': _modelNumberOfBathsController.text,
        'modelFlooringOfRooms': _modelFlooringOfRoomsController,
        'modelLightingOfRooms': _modelLightingOfRoomsController,
        'modelCeilingHeight': _modelCeilingHeightController.text,
        'modelKitchenCountertops': _modelKitchenCountertopsController,
        'modelKitchenCabinetry': _modelKitchenCabinetryController,
        'modelFlooringOfKitchen': _modelFlooringOfKitchenController,
        'modelBathroomVanity': _modelBathroomVanityController,
        'modelYard': _modelYardController,
        'modelDeck': _modelDeckController,
        'modelPatio': _modelPatioController,
        'modelParkings': _modelParkingsController,
        'modelPool': _modelPoolController,
        'modelTechnologyAndSmartFeatures':
            _modelTechnologyAndSmartFeaturesController,
      };

      Map<String, dynamic> projectData =
          await FirebaseUploads().createProject(projectInfo: projectInfo);
      if (projectData['noErrors']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AwesomeSnackbarContent(
              title: 'Hurray!',
              message: "Project was successfully created.",
              contentType: ContentType.success,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AwesomeSnackbarContent(
              title: 'Oh snap!',
              message: "Unable to create Project.",
              contentType: ContentType.failure,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      }

      // End CircularProgressIndicator
      Navigator.of(context).pop();

      // Navigator.of(context).pushNamed(
      //   UploadDesignScreen.routeName,
      //   arguments: projectData['projectId'],
      // );

      Navigator.of(context).pushNamed(ExploreModelsScreen.routeName);
    } else {
      setState(() {
        //Check for the fields are valid in TextFormField.
        if (currentStep == 0 &&
            _modelNameKey.currentState!.validate() &&
            _modelPriceKey.currentState!.validate() &&
            _modelEstimatedBuildPriceKey.currentState!.validate()) {
          currentStep = 1;
        } else if (currentStep == 1 &&
            _modelFloorsKey.currentState!.validate() &&
            _modelTotalSquareFootageKey.currentState!.validate()) {
          currentStep = 2;
        } else if (currentStep == 2 &&
            _modelNumberOfCommonRoomsKey.currentState!.validate() &&
            _modelNumberOfBedroomsKey.currentState!.validate() &&
            _modelNumberOfBathsKey.currentState!.validate() &&
            _modelCeilingHeightKey.currentState!.validate()) {
          currentStep = 3;
        } else if (currentStep == 3) {
          currentStep = 4;
        } else if (currentStep == 4) {
          currentStep = 5;
        } else if (currentStep == 5) {
          currentStep = 6;
        }
      });
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

  Widget multiSelectBuilder(
    String inputTitle,
    IconData inputIcon,
    List<MultiSelectCard> inputOptions,
    List selections,
  ) {
    return Container(
      width: 500,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                inputIcon,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              const SizedBox(width: 5),
              Text(
                inputTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 5),
          MultiSelectContainer(
            itemsPadding: const EdgeInsets.all(5),
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).canvasColor),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              selectedDecoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).canvasColor),
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            textStyles: MultiSelectTextStyles(
              textStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
            items: inputOptions,
            onChange: (allSelectedItems, selectedItem) {
              selections.clear();
              selections.addAll(allSelectedItems);
            },
          ),
        ],
      ),
    );
  }

  Widget textInputBuilder(
    Key inputKey,
    String inputTitle,
    IconData inputIcon,
    TextEditingController inputs,
    String? Function(String?) validator,
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
        validator: validator,
      ),
    );
  }

  Widget switchButtonBuilder(
    String inputTitle,
    Function(bool) onChnaged,
  ) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LiteRollingSwitch(
            width: 100,
            textOn: 'Yes',
            textOff: 'No',
            colorOn: Theme.of(context).primaryColor,
            colorOff: Theme.of(context).canvasColor,
            iconOn: Icons.done,
            iconOff: Icons.not_interested_outlined,
            animationDuration: const Duration(milliseconds: 300),
            onTap: () => null,
            onDoubleTap: () => null,
            onChanged: onChnaged,
            onSwipe: () => null,
          ),
          const SizedBox(height: 10),
          Text(
            inputTitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const CustomMenu(),
      body: MyCustomScreen(
        screenContent: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWithMenu(
              header: "Upload Project Info",
              scaffoldKey: scaffoldKey,
            ),
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
                        // onStepTapped: (step) => setState(() {
                        //   currentStep = step;
                        // }),
                        steps: [
                          Step(
                            isActive: currentStep >= 0,
                            title: Text(
                              "General Details",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      textInputBuilder(
                                        _modelNameKey,
                                        "Enter Project Name",
                                        Icons.catching_pokemon,
                                        _modelNameController,
                                         (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your project name';
                                            }
                                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                              return 'Please enter alphabets only(spaces allowed)';
                                            } 
                                            return null; // Return null if the input is valid
                                            // Additional validation logic for project name if needed
                                          },
                                      ),
                                      textInputBuilder(
                                        _modelPriceKey,
                                        "Enter Price",
                                        Icons.catching_pokemon,
                                        _modelPriceController,
                                        (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter Price';
                                          }
                                          if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
                                            return 'Please enter a valid price (e.g.- 4500/4500.00)';
                                          }
                                          // Additional validation logic for project name if needed
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      textInputBuilder(
                                        _modelEstimatedBuildPriceKey,
                                        "Enter Estimated Construction Price",
                                        Icons.catching_pokemon,
                                        _modelEstimatedBuildPriceController,
                                        (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter estimated construction price';
                                          }
                                          if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
                                            return 'Please enter a valid price (e.g.- 4500/4500.00)';
                                          }
                                          // Additional validation logic for project name if needed
                                          return null; // Return null if the input is valid
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: currentStep >= 1,
                            title: Text(
                              "Exterior",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      textInputBuilder(
                                        _modelFloorsKey,
                                        "Number of Floors",
                                        Icons.catching_pokemon_rounded,
                                        _modelFloorsController,
                                        (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter number of floors(1-7)';
                                          }
                                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                                            return 'Please enter a digit';
                                          }
                                          int floors = int.parse(value);
                                          if (floors < 1 || floors > 7) {
                                            return 'Please enter a number from 1 to 7';
                                          }
                                          // Additional validation logic for project name if needed
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                      textInputBuilder(
                                        _modelTotalSquareFootageKey,
                                        "Total Area in sqft",
                                        Icons.catching_pokemon,
                                        _modelTotalSquareFootageController,
                                        (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter Total area in sqft';
                                          }
                                          if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
                                            return 'Please enter a valid area (e.g.- 800/800.56)';
                                          }
                                          // Additional validation logic for project name if needed
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      //ColorScheme
                                      multiSelectBuilder(
                                        "Choose Colorscheme",
                                        Icons.color_lens,
                                        colorSchemeList,
                                        _modelColorSchemeController,
                                      ),
                                      multiSelectBuilder(
                                        "Choose Roof Style",
                                        Icons.roofing_rounded,
                                        roofStyleList,
                                        _modelRoofStyleController,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: currentStep >= 2,
                            title: Text(
                              "Interior",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      textInputBuilder(
                                        _modelNumberOfCommonRoomsKey,
                                        "Number of Common Rooms",
                                        Icons.catching_pokemon,
                                        _modelNumberOfCommonRoomsController,
                                        (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter number of common rooms(1-7)';
                                          }
                                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                                            return 'Please enter a digit';
                                          }
                                          int floors = int.parse(value);
                                          if (floors < 1 || floors > 7) {
                                            return 'Please enter a number from 1 to 7';
                                          }
                                          // Additional validation logic for project name if needed
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                      textInputBuilder(
                                        _modelNumberOfBedroomsKey,
                                        "Number of Bedrooms",
                                        Icons.catching_pokemon,
                                        _modelNumberOfBedroomsController,
                                        (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter number of bedrooms(1-7)';
                                          }
                                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                                            return 'Please enter a digit';
                                          }
                                          int floors = int.parse(value);
                                          if (floors < 1 || floors > 7) {
                                            return 'Please enter a number from 1 to 7';
                                          }
                                          // Additional validation logic for project name if needed
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      textInputBuilder(
                                        _modelNumberOfBathsKey,
                                        "Number of Bathrooms",
                                        Icons.catching_pokemon,
                                        _modelNumberOfBathsController,
                                        (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter number of bathrooms(1-7)';
                                          }
                                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                                            return 'Please enter a digit';
                                          }
                                          int floors = int.parse(value);
                                          if (floors < 1 || floors > 7) {
                                            return 'Please enter a number from 1 to 7';
                                          }
                                          // Additional validation logic for project name if needed
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                      textInputBuilder(
                                        _modelCeilingHeightKey,
                                        "Ceiling Height",
                                        Icons.catching_pokemon,
                                        _modelCeilingHeightController,
                                        (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter ceiling height';
                                          }
                                          if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
                                            return 'Please enter a valid height (e.g.- 8/8.56)';
                                          }
                                          // Additional validation logic for project name if needed
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      multiSelectBuilder(
                                        "Flooring of rooms",
                                        Icons.catching_pokemon,
                                        flooring,
                                        _modelFlooringOfRoomsController,
                                      ),
                                      multiSelectBuilder(
                                        "Lighting of rooms",
                                        Icons.catching_pokemon,
                                        lightingOfFloors,
                                        _modelLightingOfRoomsController,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: currentStep >= 3,
                            title: Text(
                              "Kitchen & Bathrooms",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      multiSelectBuilder(
                                        "Choose Kitchen Countertops",
                                        Icons.catching_pokemon,
                                        kitchenCountertops,
                                        _modelKitchenCountertopsController,
                                      ),
                                      multiSelectBuilder(
                                        "Choose Kitchen Cabinetry",
                                        Icons.catching_pokemon,
                                        kitchenCountertops,
                                        _modelKitchenCabinetryController,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      multiSelectBuilder(
                                        "Choose Kitchen Flooring",
                                        Icons.catching_pokemon,
                                        flooring,
                                        _modelFlooringOfKitchenController,
                                      ),
                                      multiSelectBuilder(
                                        "Choose Bathroom Vanity",
                                        Icons.catching_pokemon,
                                        bathroomVanity,
                                        _modelBathroomVanityController,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: currentStep >= 4,
                            title: Text(
                              "Outdoors",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      switchButtonBuilder(
                                        "Yard",
                                        (bool state) {
                                          setState(() {
                                            _modelYardController = state;
                                          });
                                        },
                                      ),
                                      switchButtonBuilder(
                                        "Patio",
                                        (bool state) {
                                          setState(() {
                                            _modelPatioController = state;
                                          });
                                        },
                                      ),
                                      switchButtonBuilder(
                                        "Swimming Pool",
                                        (bool state) {
                                          setState(() {
                                            _modelPoolController = state;
                                          });
                                        },
                                      ),
                                      switchButtonBuilder(
                                        "Deck",
                                        (bool state) {
                                          setState(() {
                                            _modelDeckController = state;
                                          });
                                        },
                                      ),
                                      switchButtonBuilder(
                                        "Parkings",
                                        (bool state) {
                                          setState(() {
                                            _modelParkingsController = state;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: currentStep >= 5,
                            title: Text(
                              "Technology & Energy Efficiency",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      multiSelectBuilder(
                                        "Technology & Energy Efficient tools",
                                        Icons.catching_pokemon,
                                        technologyList,
                                        _modelTechnologyAndSmartFeaturesController,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: currentStep >= 6,
                            title: Text(
                              "Upload 3d Models and Image",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      UploadImage(
                                          imgName: "2D Image",
                                          onPressed: () async {
                                            await FirebaseStorage
                                                .selectSampleFile();
                                            setState(() {});
                                          },
                                          index: -2),
                                      UploadImage(
                                          imgName: "3D model",
                                          onPressed: () async {
                                            await FirebaseStorage.select3DModel(
                                                0);
                                            setState(() {});
                                          },
                                          index: -1),
                                      UploadImage(
                                          imgName: "Birds Eye View",
                                          onPressed: () async {
                                            await FirebaseStorage.select3DModel(
                                                1);
                                            setState(() {});
                                          },
                                          index: -3),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
