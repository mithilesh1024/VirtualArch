import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:virtualarch/models/upload_model.dart';
import 'package:virtualarch/screens/error_screen.dart';
import 'package:virtualarch/screens/housemodels/exploremodels_screen.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/headerwithnavigation.dart';
import '../../widgets/housemodels/model_features.dart';

class ModelsDetailScreen extends StatefulWidget {
  const ModelsDetailScreen({super.key});
  static const routeName = '/ModelsDetail';

  @override
  State<ModelsDetailScreen> createState() => _ModelsDetailScreenState();
}

class _ModelsDetailScreenState extends State<ModelsDetailScreen> {
  bool isFavorite = false;
  bool isBirdsEyeView = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isDesktop = size.width >= 600;
    bool isMobile = size.width < 600;
    var scaffoldMessengerVar = ScaffoldMessenger.of(context);
    bool isErrorOccured = false;
    Models3D modelData = Models3D(
      modelId: "",
      modelImageURL: "",
      model3dURL: "",
      model3dBirdsView: "",
      modelName: "",
      modelPrice: 0,
      modelEstimatedBuildPrice: 0,
      modelArchitectname: "",
      modelArchitectID: "",
      modelColorScheme: [],
      modelFloors: 0,
      modelTotalSquareFootage: 0,
      modelRoofStyle: [],
      modelNumberOfCommonRooms: 0,
      modelNumberOfBedrooms: 0,
      modelNumberOfBaths: 0,
      modelFlooringOfRooms: [],
      modelLightingOfRooms: [],
      modelCeilingHeight: 0,
      modelKitchenCountertops: [],
      modelKitchenCabinetry: [],
      modelFlooringOfKitchen: [],
      modelBathroomVanity: [],
      modelYard: false,
      modelDeck: false,
      modelPatio: false,
      modelParkings: false,
      modelPool: false,
      modelTechnologyAndSmartFeatures: [],
    );
    try {
      isErrorOccured = false;
      modelData = ModalRoute.of(context)!.settings.arguments as Models3D;
    } catch (e) {
      isErrorOccured = true;
    }

    return isErrorOccured
        ? const ErrorScreen(
            screenToBeRendered: ExploreModelsScreen.routeName,
            renderScreenName: "Explore 3d Models",
          )
        : Scaffold(
            body: MyCustomScreen(
              screenContent: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWithNavigation(
                    heading: modelData.modelName,
                    screenToBeRendered: "None",
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.7,
                      width: size.width,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            // crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 20,
                            runSpacing: 10,
                            children: [
                              // ClipRRect(
                              //   borderRadius: const BorderRadius.only(
                              //     bottomLeft: Radius.circular(30),
                              //     bottomRight: Radius.circular(30),
                              //   ),
                              //   child: Image.network(
                              //     modelData.modelImageURL,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              Container(
                                height: isMobile
                                    ? size.height * 0.5
                                    : size.height * 0.8,
                                width: 600,
                                child: Stack(
                                  children: [
                                    ModelViewer(
                                      backgroundColor: Colors.black,
                                      src: modelData.model3dURL,
                                      alt: "A 3d model of astronaut",
                                      ar: true,
                                      autoPlay: true,
                                      autoRotate: true,
                                      cameraControls: true,
                                      // loading: Loading.eager,
                                      poster: "assets/fetchModel.png",
                                    ),
                                    if (isBirdsEyeView)
                                      ModelViewer(
                                        backgroundColor: Colors.black,
                                        src: modelData.model3dBirdsView,
                                        alt: "A 3d model of astronaut",
                                        ar: true,
                                        autoPlay: true,
                                        autoRotate: true,
                                        cameraControls: true,
                                        // loading: Loading.eager,
                                        poster: "assets/fetchModel.png",
                                      ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isFavorite = !isFavorite;
                                          });
                                          if (isFavorite) {
                                            scaffoldMessengerVar.showSnackBar(
                                              SnackBar(
                                                content: AwesomeSnackbarContent(
                                                  title: 'Added to favorites!',
                                                  message:
                                                      "Your favorite items are always at your fingertips.",
                                                  contentType:
                                                      ContentType.success,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                              ),
                                            );
                                          } else {
                                            scaffoldMessengerVar.showSnackBar(
                                              SnackBar(
                                                content: AwesomeSnackbarContent(
                                                  title:
                                                      'Removed from favorites!',
                                                  message:
                                                      "No worries, you can always add it back later.",
                                                  contentType: ContentType.help,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                              ),
                                            );
                                          }
                                        },
                                        icon: isFavorite
                                            ? Icon(
                                                Icons.favorite,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 500,
                                // color: Colors.green,
                                child: Column(
                                  children: [
                                    LiteRollingSwitch(
                                      width: 500,
                                      textOn: 'Birds Eye View',
                                      textOff: 'Normal View',
                                      colorOn: Theme.of(context).primaryColor,
                                      colorOff: Theme.of(context).canvasColor,
                                      iconOn: Icons.remove_red_eye,
                                      iconOff: Icons.auto_fix_normal,
                                      animationDuration:
                                          const Duration(milliseconds: 500),
                                      onTap: () => null,
                                      onDoubleTap: () => null,
                                      onChanged: (bool state) {
                                        setState(() {
                                          isBirdsEyeView = state;
                                        });
                                      },
                                      onSwipe: () => null,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    ModelFeatures(modelData: modelData),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
