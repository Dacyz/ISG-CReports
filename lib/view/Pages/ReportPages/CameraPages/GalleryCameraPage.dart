import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../controller/remote_data_source/reportes_helper.dart';
import '../../../../model/proyecto_Model.dart';
import '../../../../model/reportes_Model.dart';
import 'PhotosPrintPage.dart';

class PhotoViewScream extends StatelessWidget {
  PhotoViewScream({super.key, required this.imageFile});
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
  ProyectoModel proyectoModel;
  final ReportesModel reporte;
  galleryCamera(this.proyectoModel, {required this.reporte});

  @override
  State<galleryCamera> createState() => _galleryCameraState(nreporte: reporte);
}

class _galleryCameraState extends State<galleryCamera> {
  final ReportesModel nreporte;
  List<XFile> images = [];
  _galleryCameraState({required this.nreporte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //UiAppbar
      appBar: defaultAppBar,
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
          images.length != 3
              ? FloatingActionButton(
                  onPressed: _optionsDialogBox,
                  child: Icon(Icons.add),
                )
              : FloatingActionButton(
                  onPressed: () {},
                ),
        ],
      ),
    );
  }

  _showMessageDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text("Guardar"),
            content: const Text("¿Estás seguro que quieres guardar?"),
            actions: [
              TextButton(
                onPressed: () async {
                  //print(images[0].name);
                  List<String> imagenesurls = [];
                  nreporte.url = imagenesurls;
                  DocumentReference as = await Reportes_helper.create(
                      nreporte, widget.proyectoModel.id.toString());
                  images.forEach(
                    (element) async {
                      File imageFile = File(element.path);
                      Reference imageref = FirebaseStorage.instance.ref().child("reportes").child(widget.proyectoModel.dni.toString()).child(element.name);
                      await imageref.putFile(imageFile);
                      imagenesurls.add(await imageref.getDownloadURL());
                      as.update({
                        "url": imagenesurls,
                      });
                    },
                  );
                },
                child: const Text("Sí"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop("Cancel"),
                child: const Text("No"),
              )
            ],
          ));

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
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
}
