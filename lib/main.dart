import 'package:camera_application/screens/homepage.dart';
import 'package:camera_application/screens/widget_scree.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'camera application',
      theme:ThemeData.dark(),
      home: const HomePage(),
      routes: {
        ScrenWidget.routName:(ctx)=>ScrenWidget()
      },
    );
  }
}
