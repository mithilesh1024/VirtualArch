import 'package:flutter/material.dart';

class AddButtonDesign extends StatelessWidget {
  const AddButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).canvasColor,
          shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset("assets/add.png"),
      ),
    );
  }
}
