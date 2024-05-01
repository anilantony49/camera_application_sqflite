// import 'package:camera/camera.dart';
import 'package:camera_application/data_repository/dbHelper.dart';
import 'package:camera_application/manager/image_manager.dart';
import 'package:camera_application/ui/screens/home_screen.dart';
import 'package:camera_application/ui/screens/new_image_screen.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure camera permission before initializing the database

  // Initialize the database
  await DbHelper.dbHelper.initDatabase();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InitApp();
  }
}

class InitApp extends StatefulWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  @override
  void initState() {
    ImageManager().getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Gallery App',
      home: const HomeScreen(),
      routes: {
        '/new_image_screen': (context) => const NewImageScreen(),
        '/main_screen': (context) => const HomeScreen(),
      },
    );
  }
}
