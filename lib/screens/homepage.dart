import 'package:camera_application/screens/widget_scree.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Gallary'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.image,color: Colors.white,),
        onPressed: (){
          Navigator.pushNamed(context, ScrenWidget.routName);
        }),
    );
  }
}