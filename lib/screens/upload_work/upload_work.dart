import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../firebase/firebase_storage.dart';
import '../../widgets/custommenu.dart';
import '../../widgets/customscreen.dart';
import '../../widgets/headerwithmenu.dart';

class UploadWorkScreen extends StatelessWidget {
  UploadWorkScreen({super.key});
  static const routeName = "/uploadWork";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
              header: "Upload Work",
              scaffoldKey: scaffoldKey,
            ),
            ElevatedButton(
                onPressed: () async {
                  // final result =
                  //     await FilePicker.platform.pickFiles(allowMultiple: true);
                  await FirebaseStorage.uploadModel();
                },
                child: Text("press"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
