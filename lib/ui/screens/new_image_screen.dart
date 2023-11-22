import 'dart:io';

import 'package:camera_application/data_repository/dbHelper.dart';
import 'package:camera_application/manager/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


import 'widgets/constants.dart';

class NewImageScreen extends StatefulWidget {
  const NewImageScreen({super.key});

  @override
  State<NewImageScreen> createState() => _NewImageScreenState();
}

class _NewImageScreenState extends State<NewImageScreen> {
  // function to pick an image by camera or from gallary
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      ImageManager().image = File(image.path);
    });
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
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

  // late AncestorWidget _ancestor;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Save a reference to the ancestor widget
  //   _ancestor = context.dependOnInheritedWidgetOfExactType<AncestorWidget>()!;
  // }

  // @override
  // void dispose() {
  //   _ancestor.someDisposeLogic();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    ImageManager imageManager = ImageManager();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xC1C1C1C1),
          title: const Text('Add Images'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          color: Colors.black),
                      child: imageManager.image != null
                          ? Image.file(
                              imageManager.image!,
                              fit: BoxFit.cover,
                            )
                          : Center(child: Text('No images')),
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          await _requestCameraPermission();
                          pickImage(context, ImageSource.camera);
                        },
                        icon: Icon(Icons.camera),
                        label: Text('Add Image'))
                    // IconButton(onPressed: onPressed, icon: icon)
                  ],
                ),
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
                    }),
                kHeight1,
                ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color(0xC1C1C1C1),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        imageManager.insertNewImage();

                        imageManager.nameController.clear();
                        imageManager.ageController.clear();

                        refresh();
                        Navigator.of(context).pop();

                        if (imageManager.image != null &&
                            File(imageManager.image!.path).existsSync()) {
                          // Request storage permission
                          var status = await Permission.storage.status;
                          if (!status.isGranted) {
                            await Permission.storage.request();
                          }

                          // Save the image to the gallery
                          await GallerySaver.saveImage(
                              imageManager.image!.path);

                          // Set imageManager.image to null after saving
                          imageManager.image = null;

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Save Successfully'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(10),
                          ));
                        } else {
                          print('Image is null or does not exist');
                        }
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
