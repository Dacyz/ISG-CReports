import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';
import '../../../../model/proyecto_Model.dart';
import '../../../../model/reportes_Model.dart';
import 'PhotoViewScream.dart';
import 'PhotosPrintPage.dart';

class GalleryCameraPage extends StatefulWidget {
  final ProyectoModel proyectoModel;
  final ReportesModel reporte;
  const GalleryCameraPage(this.proyectoModel, {super.key, required this.reporte});

  @override
  State<GalleryCameraPage> createState() => _GalleryCameraPageState(nreporte: reporte);
}

class _GalleryCameraPageState extends State<GalleryCameraPage> {
  final ReportesModel nreporte;
  List<XFile> images = [XFile('')];
  _GalleryCameraPageState({required this.nreporte});

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
                              builder: (context) => PhotosPrintPage()));
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

  /*
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
          ));*/
}
