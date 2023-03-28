import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/custommenu.dart';
import '../widgets/customscreen.dart';
import '../widgets/headerwithmenu.dart';
import '../widgets/housemodels/modelscard.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});
  static const routeName = "/display";

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
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
              header: "My Uploads",
              scaffoldKey: scaffoldKey,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    SizedBox(
                      height: size.height * 0.7,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 0,
                            ),
                            child: ModelsCard(),
                          );
                        },
                      ),
                    )
                    // const ModelsCard(),
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
