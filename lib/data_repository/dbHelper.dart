import 'dart:io';

import 'package:camera_application/model/image_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String tableName = 'gallary';
  final String titleColumn = 'title';
  final String idColumn = 'id';
  final String descriptionColumn = 'description';
  final String imageColumn = 'image';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    // Get the location uisng getDatabasePath
    Directory directory = await getApplicationDocumentsDirectory();

    // to specific name of database

    String path = "$directory/gallary.db";

    // to create database
    return openDatabase(
      path, version: 1,

      // to create the table
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $titleColumn TEXT, $descriptionColumn TEXT,'
            '$imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $titleColumn TEXT, $descriptionColumn TEXT,'
            '$imageColumn TEXT)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }
// to read data

  Future<List<ImageModel>> getAllImages() async {
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => ImageModel.fromMap(e)).toList();
  }

// to insert some data
  insetNewImage(ImageModel imageModel) {
    database.insert(tableName, imageModel.toMap());
  }

// to delete one column from table

  deleteImage(ImageModel imageModel) {
    database
        .delete(tableName, where: "$idColumn =?", whereArgs: [imageModel.id]);
  }

// to delete all of table

  deleteImages() {
    database.delete(tableName);
  }

// to update data

  updateImage(ImageModel imageModel) async {
    await database.update(
        tableName,
        {
          titleColumn: imageModel.title,
          descriptionColumn: imageModel.description,
          imageColumn: imageModel.image!.path,
        },
        where: '$idColumn=?',
        whereArgs: [imageModel.id]);
  }
}
