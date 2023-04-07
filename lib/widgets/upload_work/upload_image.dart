import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadImage extends StatelessWidget {
  // final Image preview;
  final String imgName;
  final VoidCallback onPressed;
  const UploadImage({
    super.key,
    // required this.preview,
    required this.imgName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onPressed,
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Theme.of(context).secondaryHeaderColor,
          radius: const Radius.circular(12),
          strokeWidth: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              width: 300,
              height: 250,
              child: Center(
                child: Column(
                  children: [
                    Image.asset("assets/Preview.png"),
                    Text(
                      "Click me to Upload $imgName",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
