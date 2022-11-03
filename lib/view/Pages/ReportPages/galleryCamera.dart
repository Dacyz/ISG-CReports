import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

import '../../System/Home/HomePage.dart';
import 'listproyect.dart';
import 'photosPrint.dart';

class PhotoViewScream extends StatelessWidget {
  PhotoViewScream({required this.imageFile});
  File imageFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: FileImage(imageFile),
      ),
    );
  }
}

class galleryCamera extends StatefulWidget {
  @override
  State<galleryCamera> createState() => _galleryCameraState();
}

class _galleryCameraState extends State<galleryCamera> {
  List<XFile> images = [];
  ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //UiAppbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/images/logooficial2.png",
            height: 30,
            width: 40,
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Cámara",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.brightness_medium_outlined,
              color: Color(0xFFF27900),
            ),
          )
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          File imageFile = File(images[index].path);
          return Card(
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoViewScream(
                                imageFile: imageFile,
                              )));
                },
                child: Image.file(imageFile)),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 80,
          ),
          ElevatedButton(
            onPressed: () {
              _showMessageDialog(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: const Text("Guardar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                )),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF2196F3),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 14),
              side: BorderSide(color: Color(0xFF084460)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              shadowColor: Colors.lightBlue,
            ),
          ),
          FloatingActionButton(
            onPressed: _optionsDialogBox,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _openCamera() async {
    XFile? picture = await _imagePicker.pickImage(source: ImageSource.camera);
    Navigator.pop(context);
    setState(() {
      images.add(picture!);
    });
  }

  void _openGallery() async {
    XFile? picture = await _imagePicker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
    setState(() {
      images.add(picture!);
    });
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  // GestureDetector(
                  //   child: Text('image_picker: Take a picture'),
                  //   onTap: _openCamera,
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.all(8)
                  // ),
                  // GestureDetector(
                  //   child: Text("image_picker: Select from gallery"),
                  //   onTap: _openGallery,
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.all(8)
                  // ),
                  GestureDetector(
                    child: new Text("Usar Cámara"),
                    onTap: () async {
                      String paths = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => photoPrint()));
                      //
                      XFile pickedFile = XFile(paths);
                      images.add(pickedFile);
                      //regresar al modal
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showMessageDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Guardar"),
          content: Text("¿Estás seguro que quieres guardar?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
              child: const Text("Sí"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop("Cancel"),
              child: const Text("No"),
            )
          ],
        ),
      );
}
