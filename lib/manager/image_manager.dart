import 'dart:io';

import 'package:camera_application/data_repository/dbHelper.dart';
import 'package:camera_application/model/image_model.dart';
import 'package:flutter/material.dart';

class ImageManager {
  static final ImageManager _instance = ImageManager._internal();

  factory ImageManager() {
    return _instance;
  }

  ImageManager._internal() {
    getImages();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  File? image;

  List<ImageModel> allImages = [];

  Future<void> getImages() async {
    allImages = await DbHelper.dbHelper.getAllImages();
  }

  void insertNewImage() {
    ImageModel imageModel = ImageModel(
      title: nameController.text,
      image: image,
      description: ageController.text,
    );

    DbHelper.dbHelper.insetNewImage(imageModel);
  }

  Future<void> updateImage(ImageModel imageModel) async {
    await DbHelper.dbHelper.updateImage(imageModel);
  }

  void deleteImage(ImageModel imageModel) {
    DbHelper.dbHelper.deleteImage(imageModel);
  }
}
