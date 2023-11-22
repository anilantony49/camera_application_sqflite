
import 'package:camera_application/model/image_model.dart';
import 'package:camera_application/ui/screens/show_image_screen.dart';
import 'package:flutter/material.dart';


class ImageGridWidget extends StatelessWidget {
  final ImageModel imageModel;

  const ImageGridWidget(
    this.imageModel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowImageScreen(imageModel: imageModel),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration( border: Border.all(width: 2, color: Colors.grey)),
          width: 100,
          height: 100,
          // color: kColor,
          child: Image.file(
            imageModel.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
