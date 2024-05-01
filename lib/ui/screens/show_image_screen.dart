import 'package:camera_application/data_repository/dbHelper.dart';
import 'package:camera_application/manager/image_manager.dart';
import 'package:camera_application/model/image_model.dart';
import 'package:camera_application/ui/screens/edit_image_screen.dart';
import 'package:camera_application/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/constants.dart';

class ShowImageScreen extends StatefulWidget {
  final ImageModel imageModel;
  const ShowImageScreen({super.key, required this.imageModel});

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  void refresh() async {
    final data = await DbHelper.dbHelper.getAllImages();
    setState(() {
      ImageManager().allImages = data;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xC1C1C1C1),
        actions: [
          InkWell(
            onTap: () {
              ImageManager imageManager = ImageManager();
              imageManager.nameController.text = widget.imageModel.title;
              imageManager.ageController.text =
                  widget.imageModel.description.toString();

              imageManager.image = widget.imageModel.image!;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditImageScreen(imageModel: widget.imageModel),
                ),
              );
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      title: const Text('Delete'),
                      content: const Text('Are you sure want to delete?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              ImageManager().deleteImage(widget.imageModel);
                              refresh();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Delete succesfully'),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                              ));
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: kColor),
                            )),
                        TextButton(
                            onPressed: () {
                              // Navigator.popUntil(
                              //     context, (route) => route.isFirst);
                              // Navigator.push(`
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => HomeScreen()));
                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreen()), (route) => false);
                              Navigator.of(context).pop();
                              // Navigator.pushNamedAndRemoveUntil(context, '/main_screen', (route) => false);

                            },
                            child: const Text(
                              'No',
                              style: TextStyle(color: kColor),
                            ))
                      ],
                    );
                  });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: kColor,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 250,
          width: double.infinity,
          child: widget.imageModel.image == null ||
                  widget.imageModel.image!.path.isEmpty
              ? const Center(
                  child: Text(
                  'No Images',
                  style: TextStyle(color: Colors.white),
                ))
              : Image.file(
                  widget.imageModel.image!,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
