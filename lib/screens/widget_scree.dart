import 'dart:io';

import 'package:flutter/material.dart';

class ScrenWidget extends StatelessWidget {
  ScrenWidget({super.key});
  static const routName = 'ScreenWidget';
  File? imagefile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('input page'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.save)),
          SizedBox(width: 20,)
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  color: Colors.black),
              child: imagefile != null
                  ? Image.file(
                      imagefile!,
                      fit: BoxFit.cover,
                    )
                  : Center(child: Text('No images')),
            ),
            
            
          ),
          SizedBox(
            height: 20,
          ),
          TextButton.icon(onPressed: (){}, icon: Icon(Icons.image,color: Colors.white,), label: Text('Add Image',style: TextStyle(color: Colors.white),))
              ,    TextButton.icon(onPressed: (){}, icon: Icon(Icons.camera,color: Colors.white,), label: Text('Take Image',style: TextStyle(color: Colors.white),))

        ],
      ),
    );
  }
}
