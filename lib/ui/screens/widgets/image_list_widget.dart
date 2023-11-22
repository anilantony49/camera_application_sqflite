// import 'package:database_student/model/image_model.dart';

// import 'package:database_student/ui/screens/show_image_screen.dart';
// import 'package:flutter/material.dart';

// import 'constants.dart';

// class ImageListWidget extends StatelessWidget {
//   final ImageListWidget imageModel;
//   const ImageListWidget(
//     this.imageModel, {
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // StudentManager studentManager = StudentManager();

//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     ShowImageScreen(imageModel: imageModel)));
//       },
//       child: Container(
//         height: 80,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListTile(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               tileColor:kColor,
//               leading: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 3),
//                 child: CircleAvatar(
//                   radius: 35,

//                   // backgroundImage: studentManager.image==null||studentManager.image!.isEmpty ?  AssetImage('assets/images/blank profile.jpg'):FileImage(studentManager.image!),
//                   backgroundImage: FileImage(imageModel.image!),
//                 ),
//               ),
//               title: Text(
//                 imageModel.name,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
