import 'dart:io';

import 'package:camera_application/data_repository/dbHelper.dart';
import 'package:camera_application/manager/image_manager.dart';
import 'package:camera_application/model/image_model.dart';
import 'package:camera_application/ui/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/constants.dart';

class EditImageScreen extends StatefulWidget {
  final ImageModel imageModel;
  const EditImageScreen({super.key, required this.imageModel});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      ImageManager().image = File(image.path);
    });
  }

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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ImageManager imageManager = ImageManager();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xC1C1C1C1),
          title: const Text('Edit'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Container(
                  //       height: 200,
                  //       width: 200,
                  //       decoration: BoxDecoration(
                  //           border: Border.all(width: 2, color: Colors.grey),
                  //           color: Colors.black),
                  //       child: imageManager.image != null
                  //           ? Image.file(imageManager.image!)
                  //           : Center(child: Text('No images')),
                  //     ),
                  //     TextButton.icon(
                  //         onPressed: () {
                  //           pickImage(context, ImageSource.camera);
                  //         },
                  //         icon: Icon(Icons.camera),
                  //         label: Text('Add Image'))
                  //     // IconButton(onPressed: onPressed, icon: icon)
                  //   ],
                  // ),
                  kHeight2,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: imageManager.nameController,
                    decoration: InputDecoration(
                        label: const Text(
                          'Title',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill this field';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight1,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                 
                    controller: imageManager.ageController,
                    decoration: InputDecoration(
                        label: const Text(
                          'Description',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill this field';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight1,
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color(0xC1C1C1C1),
                      )),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          widget.imageModel.title =
                              imageManager.nameController.text;
                          widget.imageModel.description =
                             imageManager.ageController.text;
                          widget.imageModel.image = imageManager.image;

                          imageManager.updateImage(widget.imageModel);
                          imageManager.nameController.clear();
                          imageManager.ageController.clear();

                          // imageManager.image = null;
                          refresh();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Edit Succesfully'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(10),
                          ));
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.black),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
