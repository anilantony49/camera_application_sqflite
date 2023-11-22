import 'dart:io';

class ImageModel {
  int? id;
  late String title;
  File? image;
  late String description;

  ImageModel({
    this.id,
    required this.title,
    this.image,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image == null ? '' : image!.path
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'] != null ? File(map['image']) : null,
    );
  }
}
