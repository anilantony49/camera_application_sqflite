import 'dart:io';

import 'package:flutter/material.dart';

class MyPopupMenuButton extends StatefulWidget {
  const MyPopupMenuButton({super.key});

  @override
  State<MyPopupMenuButton> createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: const Color.fromARGB(255, 85, 78, 78),
      itemBuilder: (context) =>
          [PopupMenuItem(onTap: () => exit(0), child: const Text('Exit'))],
    );
  }
}
