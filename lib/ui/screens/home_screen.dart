
import 'package:camera_application/data_repository/dbHelper.dart';
import 'package:camera_application/manager/image_manager.dart';
import 'package:camera_application/ui/screens/widgets/image_grid_widget.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MainImageScreenState();
}

class _MainImageScreenState extends State<HomeScreen> {
  
  void refresh() async {
    final data = await DbHelper.dbHelper.getAllImages();
    setState(() {
      ImageManager().allImages = data;
    });
  }


  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC1C1C1C1),
        title: const Text('Gallary'),
        // actions: [
        //   InkWell(
        //     onTap: () => Navigator.of(context).push(
        //       MaterialPageRoute(
        //           builder: (context) => SearchStudentScreen(
        //               students: studentManager.allStudents)),
        //     ),
        //     child: const Icon(Icons.search),
        //   ),
        //   IconButton(
        //     onPressed: toogleView,
        //     icon: isGridView
        //         ? const Icon(Icons.list)
        //         : const Icon(Icons.grid_view),
        //   ),
        //   const MyPopupMenuButton()
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: const Color(0xC1C1C1C1),
        onPressed: () async {
          await Navigator.pushNamed(context, '/new_image_screen');
          Navigator.pushReplacementNamed(context, '/main_screen');
        },
        child: const Icon(Icons.add),
      ),
      
      body: buildGridView() 
    );
  }



  Widget buildGridView() {
    ImageManager imageManager = ImageManager();

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20, // Spacing between columns
          mainAxisSpacing: 20, // Spacing between rows
          childAspectRatio: 1,
        ),
        itemCount: imageManager.allImages.length,
        itemBuilder: (context, index) {
          return ImageGridWidget(imageManager.allImages[index]);
        });
  }
}
