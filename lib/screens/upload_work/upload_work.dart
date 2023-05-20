import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:virtualarch/widgets/upload_work/upload_image.dart';
import '../../firebase/firebase_storage.dart';
import '../../widgets/custommenu.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/headerwithmenu.dart';
import '../../widgets/upload_work/add_design_button.dart';

class UploadDesignScreen extends StatefulWidget {
  const UploadDesignScreen({super.key});
  @override
  State<UploadDesignScreen> createState() => _UploadDesignScreenState();
  static const routeName = '/uploadDesign';
}

class _UploadDesignScreenState extends State<UploadDesignScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List imageLinks = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var projectId = ModalRoute.of(context)!.settings.arguments as String;
    var projectId = "s7R3052AT888poIzLEJI";
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const CustomMenu(),
      body: MyCustomScreen(
        // customColor: Colors.blue,
        screenContent: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWithMenu(
              header: "Upload Designs",
              scaffoldKey: scaffoldKey,
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     // final result =
            //     //     await FilePicker.platform.pickFiles(allowMultiple: true);
            //     await FirebaseStorage.uploadModel();
            //   },
            //   child: Text("press"),
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.white,
            //   ),
            // ),
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
                      // UploadImage(
                      //   imgName: "Floor Plans",
                      //   index: 0,
                      //   onPressed: () async {
                      //     // final result =
                      //     //     await FilePicker.platform.pickFiles(allowMultiple: true);
                      //     await FirebaseStorage.selectFile(0);
                      //     setState(() {});
                      //   },
                      // ),
                      SizedBox(
                        height: size.height,
                        child: ResponsiveGridList(
                          rowMainAxisAlignment: MainAxisAlignment.end,
                          minItemsPerRow: 1,
                          minItemWidth: 300,
                          listViewBuilderOptions: ListViewBuilderOptions(
                            padding: EdgeInsets.zero,
                          ),
                          children: List.generate(
                            5,
                            (index) => UploadImage(
                              imgName: "Design $index",
                              index: 0,
                              onPressed: () async {
                                // final result =
                                //     await FilePicker.platform.pickFiles(allowMultiple: true);
                                await FirebaseStorage.selectFile(0);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      const AddButtonDesign(),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(24.0)),
                      //     padding: const EdgeInsets.all(12.0),
                      //   ),
                      //   onPressed: () async {
                      //     await FirebaseStorage.uploadModel(projectId);
                      //     print(FirebaseStorage.model);
                      //     if (FirebaseStorage.model != null) {
                      //       //await FirebaseStorage.upload3DModel(projectId);
                      //     }
                      //     print("uploaded");
                      //   },
                      //   child: const Text(
                      //     'Button',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
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
