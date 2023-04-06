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
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onPressed,
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: Theme.of(context).secondaryHeaderColor,
              radius: const Radius.circular(12),
              strokeWidth: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  width: size.width * 0.4,
                  height: size.height * 0.3,
                  child: Center(
                    child: Text(
                      "Click me to Upload $imgName",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              width: size.width * 0.4,
              height: size.height * 0.3,
              color: Theme.of(context).canvasColor,
              child: Image.asset("assets/Preview.png", fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
