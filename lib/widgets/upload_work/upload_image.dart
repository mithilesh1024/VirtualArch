import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:virtualarch/widgets/upload_work/add_design_button.dart';
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
          color: Theme.of(context).primaryColor,
          radius: const Radius.circular(15),
          strokeWidth: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: SizedBox(
              width: index < 0 ? 200 : 300,
              height: index < 0 ? 100 : 200,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (index == -1) ...[
                      FirebaseStorage.model[0] == null
                          ? Text(
                              "Upload $imgName",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : Text(
                              FirebaseStorage.model[0].files.single.name,
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                    ] else if (index == -2) ...[
                      FirebaseStorage.sample_image == null
                          ? Text(
                              "Upload $imgName",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : Text(
                              FirebaseStorage.sample_image.files.single.name,
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                    ] else if (index == -3) ...[
                      FirebaseStorage.model[1] == null
                          ? Text(
                              "Upload $imgName",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : Text(
                              FirebaseStorage.model[1].files.single.name,
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                    ] else ...[
                      image[index] == null
                          ? Text(
                              "Upload Design",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : Image.memory(
                              image[index].files.single.bytes,
                              width: 300,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
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
