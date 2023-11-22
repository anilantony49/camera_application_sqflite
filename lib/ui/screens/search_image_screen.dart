// import 'package:database_student/model/image_model.dart';
// import 'package:database_student/ui/screens/widgets/image_list_widget.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class SearchImagesScreen extends StatefulWidget {
//   final List<ImageModel> images;
//   List<ImageModel> filterImages = [];
//   SearchImagesScreen({super.key, required this.images}) {
//     filterImages = images;
//   }

//   @override
//   State<SearchImagesScreen> createState() => _SearchImageScreenState();
// }

// class _SearchImageScreenState extends State<SearchImagesScreen> {
//   void filterStudents(value) {
//     setState(() {
//       widget.filterImages = widget.images
//           .where((student) =>
//               student.name.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//                 backgroundColor: const Color(0xC1C1C1C1),

//         title: TextField(
//           onChanged: (value) {
//             filterStudents(value);
//           },
//           decoration: const InputDecoration(
//               icon: Icon(
//             Icons.search,
//             color: Colors.black,
//           )),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   Navigator.pop(context);
//                 });
//               },
//               icon: const Icon(Icons.cancel))
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: widget.filterImages.isNotEmpty
//             ? ListView.builder(
//                 itemCount: widget.filterImages.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ImageListWidget(widget.filterImages[index]);
//                 })
//             : const Center(
//                 child: Text('Student not found'),
//               ),
//       ),
//     );
//   }
// }
