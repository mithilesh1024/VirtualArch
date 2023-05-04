import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../firebase/firebase_storage.dart';

class UploadImage extends StatelessWidget {
  // final Image preview;
  final String imgName;
  final VoidCallback onPressed;
  final int index;
  const UploadImage({
    super.key,
    // required this.preview,
    required this.imgName,
    required this.onPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var image = FirebaseStorage.images;
    // print(image[index] == null
    //     ? "assets/Preview.png"
    //     : "image ${image[index].lengthInBytes}");
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
                    if (index == -1) ...[
                      FirebaseStorage.model == null
                          ? Image.asset("assets/Preview.png")
                          : Text(
                              "Uploaded",
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                    ] else if (index == -2) ...[
                      FirebaseStorage.sample_image == null
                          ? Image.asset("assets/Preview.png")
                          : Image.memory(
                              FirebaseStorage.sample_image.files.single.bytes,
                              width: 300,
                              height: 220),
                    ] else ...[
                      image[index] == null
                          ? Image.asset("assets/Preview.png")
                          : Image.memory(image[index].files.single.bytes,
                              width: 300, height: 220),
                      image[index] == null
                          ? Text(
                              "Click me to Upload $imgName",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : Text(
                              image[index].files.single.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                    ]
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
