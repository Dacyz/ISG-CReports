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
  List<XFile> images = [XFile('')];
  _galleryCameraState({required this.nreporte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //UiAppbar
      appBar: defaultAppBar,
      body: SafeArea(
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              File imageFile = File(images[index].path);
              if (images.length - 1 == index) {
                if (images.length < 6) {
                  return IconButton(
                    onPressed: () async {
                      String paths = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => photoPrint()));
                      XFile pickedFile = XFile(paths);
                      images.insert(0, pickedFile);
                      setState(() {});
                    },
                    icon: const Icon(Icons.add),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return Stack(children: [
                  Card(
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
                  ),
                  Positioned(
                      top: 1,
                      right: 1,
                      child: IconButton(
                          onPressed: () {
                            images.removeAt(index);
                            setState(() {});
                          },
                          icon: const Icon(Icons.close))),
                ]);
              }
            },
          ),
        ),
      ),
    );
  }

  _showMessageDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text("Guardar"),
            actions: [
              TextButton(
                onPressed: () async {
                  List<String> imagenesurls = [];
                  nreporte.url = imagenesurls;
                  DocumentReference as = await Reportes_helper.create(
                      nreporte, widget.proyectoModel.id.toString());
                  for (var i = 0; i < images.length; i++) {
                    if (images.length - 1 != i) {
                      File imageFile = File(images.elementAt(i).path);
                      Reference imageref = FirebaseStorage.instance
                          .ref()
                          .child("reportes")
                          .child(widget.proyectoModel.dni.toString())
                          .child(images.elementAt(i).name);
                      await imageref.putFile(imageFile);
                      imagenesurls.add(await imageref.getDownloadURL());
                      as.update({
                        "url": imagenesurls,
                      });
                    }
                  }
                },
                child: const Text("Sí"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop("Cancel"),
                child: const Text("No"),
              )
            ],
          ));
}
