import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:virtualarch/widgets/upload_work/upload_image.dart';
import '../../firebase/firebase_storage.dart';
import '../../widgets/custommenu.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/headerwithmenu.dart';

class UploadDesignScreen extends StatefulWidget {
  const UploadDesignScreen({super.key});
  @override
  State<UploadDesignScreen> createState() => _UploadDesignScreenState();
  static const routeName = '/uploadDesign';
}

class _UploadDesignScreenState extends State<UploadDesignScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                    children: [
                      UploadImage(
                        imgName: "Floor Plans",
                        index: 0,
                        onPressed: () async {
                          // final result =
                          //     await FilePicker.platform.pickFiles(allowMultiple: true);
                          await FirebaseStorage.selectFile(0);
                          setState(() {});
                        },
                      ),
                      UploadImage(
                        imgName: "Elevations Plan",
                        index: 1,
                        onPressed: () async {
                          // final result =
                          //     await FilePicker.platform.pickFiles(allowMultiple: true);
                          await FirebaseStorage.selectFile(1);
                          setState(() {});
                        },
                      ),
                      UploadImage(
                        imgName: "Site Plan",
                        index: 2,
                        onPressed: () async {
                          // final result =
                          //     await FilePicker.platform.pickFiles(allowMultiple: true);
                          await FirebaseStorage.selectFile(2);
                          setState(() {});
                        },
                      ),
                      UploadImage(
                        imgName: "Foundational Plan",
                        index: 3,
                        onPressed: () async {
                          // final result =
                          //     await FilePicker.platform.pickFiles(allowMultiple: true);
                          await FirebaseStorage.selectFile(3);
                          setState(() {});
                        },
                      ),
                      UploadImage(
                        imgName: "Electric Plan",
                        index: 4,
                        onPressed: () async {
                          // final result =
                          //     await FilePicker.platform.pickFiles(allowMultiple: true);
                          await FirebaseStorage.selectFile(4);
                          setState(() {});
                        },
                      ),
                      UploadImage(
                        imgName: "Plumbing Plan",
                        index: 5,
                        onPressed: () async {
                          // final result =
                          //     await FilePicker.platform.pickFiles(allowMultiple: true);
                          await FirebaseStorage.selectFile(5);
                          setState(() {});
                        },
                      ),
                      UploadImage(
                        imgName: "HVAC Plan",
                        index: 6,
                        onPressed: () async {
                          // final result =
                          //     await FilePicker.platform.pickFiles(allowMultiple: true);
                          await FirebaseStorage.selectFile(6);
                          setState(() {});
                        },
                      ),
                      UploadImage(
                        imgName: "Other Plan",
                        index: 7,
                        onPressed: () async {
                          // final result =
                          //     await FilePicker.platform.pickFiles(allowMultiple: true);
                          await FirebaseStorage.selectFile(7);
                          setState(() {});
                        },
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            padding: const EdgeInsets.all(12.0),
                          ),
                          onPressed: () async {
                            await FirebaseStorage.uploadModel();
                          },
                          child: const Text('Button',
                              style: TextStyle(color: Colors.white))),
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
