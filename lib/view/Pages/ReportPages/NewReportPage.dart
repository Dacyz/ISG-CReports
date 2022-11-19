import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/remote_data_source/reportes_helper.dart';
import '../../../model/proyecto_Model.dart';
import '../../../model/reportes_Model.dart';
import '../../System/ProfileConstant.dart';
import 'CameraPages/GalleryCameraPage.dart';
import 'CameraPages/PhotosPrintPage.dart';

class newreport extends StatefulWidget {
  ProyectoModel proyectoModel;
  newreport(this.proyectoModel);
  @override
  State<newreport> createState() => _newreportState();
}

class _newreportState extends State<newreport> {
  List<XFile> images = [XFile('')];

  bool isVisible2 = true;
  bool isVisible3 = false;
  bool isVisible4 = true;

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;

  int? groupValue = 3;
  int? groupValueInit;

  //Varobservacion
  TextEditingController _observacionController = TextEditingController();

  void dispose() {
    _observacionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    groupValueInit = groupValue! - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(defaultPadding),
        child: ElevatedButton(
          onPressed: () {
            if (images.length == 1) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Debes agregar almenos una fotografia"),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {},
                ),
              ));
            } else {
              _showMessageDialog(context);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 14),
            side: const BorderSide(color: Color(0xFF084460)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.lightBlue,
          ),
          child: const Text("Guardar",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white)),
        ),
      ),
      //UiAppbar
      appBar: defaultAppBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 125,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _radiocategorias("Entrega de Materiales", 1),
                  _radiocategorias("Ubicación y limpieza de terreno", 2),
                  _radiocategorias(
                      "Trazo y excavación de zanjas para cimiento", 3),
                  _radiocategorias("Armado de columnas", 4),
                  _radiocategorias("Vaciado de cimientos", 5),
                  _radiocategorias("Armado y vaciado de sobrecimiento", 6),
                  _radiocategorias("Asentado de ladrillos", 7),
                  _radiocategorias("Vaciado de Columna", 8),
                  _radiocategorias("Acero de techo y encofrado", 9),
                ],
              ),
            ),
            _RowTitle("CheckList", isVisible2, () {
              setState(() {
                isVisible2 = !isVisible2;
              });
            }),
            //Checklist
            Visibility(
              visible: isVisible2,
              maintainState: true,
              child: Column(
                children: [
                  _CheckRow('Se encontraba el Beneficiario', value1, (value) {
                    value1 = value!;
                    (context as Element).markNeedsBuild();
                  }),
                  _CheckRow('Se encontraba el maestro a cargo', value2,
                      (value) {
                    value2 = value!;
                    (context as Element).markNeedsBuild();
                  }),
                  _CheckRow('Se encontraban obreros trabajando', value3,
                      (value) {
                    value3 = value!;
                    (context as Element).markNeedsBuild();
                  }),
                ],
              ),
            ),
            //Titulo Fotografias
            _RowTitle("Fotografias", isVisible4, () {
              setState(() {
                isVisible4 = !isVisible4;
              });
            }),
            //Observacion
            Visibility(
              visible: isVisible4,
              maintainState: true,
              child: images.length != 1
                  ? SizedBox(
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
                                              builder: (context) =>
                                                  PhotoViewScream(
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
                    )
                  : Center(
                      child: Column(
                        children: [
                          const Text('Aún no hay evidencias'),
                          TextButton.icon(
                            label: const Text('Agregar evidencia'),
                            onPressed: () async {
                              String paths = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => photoPrint()));
                              XFile pickedFile = XFile(paths);
                              images.insert(0, pickedFile);
                              setState(() {});
                            },
                            icon: Icon(Icons.add),
                          )
                        ],
                      ),
                    ),
            ),
            //Titulo Observacion
            _RowTitle("Observación", isVisible3, () {
              setState(() {
                isVisible3 = !isVisible3;
              });
            }),
            //Observacion
            Visibility(
              visible: isVisible3,
              maintainState: true,
              child: Card(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _observacionController,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline, //or null
                      decoration: const InputDecoration.collapsed(
                        hintText: "Ingresa tu observación aquí",
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(200)],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _radiocategorias(String title, int index) {
    return Container(
      width: 120,
      child: Card(
        color: index > groupValueInit! ? Colors.white : Colors.white54,
        child: Column(
          children: [
            Radio(
              value: index,
              activeColor:
                  index - 1 == groupValueInit! ? Colors.blue : secondColor,
              groupValue: groupValue,
              onChanged: (newValue) {
                setState(() {
                  if (index > groupValueInit!) {
                    groupValue = newValue!;
                  }
                });
              },
            ),
            Expanded(
                child: Text(
              title,
              textAlign: TextAlign.center,
            ))
          ],
        ),
      ),
    );
  }

  //Metodo Mensaje de confimasion siguiente
  _showMessageDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text("Guardar reporte"),
            content: const Text("¿Está seguro de registrar este reporte?"),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    ReportesModel reportenuevo = ReportesModel(
                        estado: groupValue,
                        fecharegistro: DateTime.now(),
                        preguntaone: value1,
                        preguntatwo: value2,
                        preguntathree: value3,
                        observacion: _observacionController.text);
                    List<String> imagenesurls = [];
                    reportenuevo.url = imagenesurls;
                    DocumentReference as = await Reportes_helper.create(
                        reportenuevo, widget.proyectoModel.id.toString());
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
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Ocurrio un error"),
                    ));
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

  _RowTitle(String title, bool Boolean, void Function() funcion) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: funcion,
            icon: Icon(
              Boolean ? Icons.arrow_drop_down : Icons.arrow_drop_up,
              color: Colors.black,
            ),
          ),
        ],
      );

  _CheckRow(String description, bool Boolean, Function(bool? value) funcion) =>
      Row(
        children: [
          Transform.scale(
            scale: 1,
            child: Checkbox(
              activeColor: secondColor,
              value: Boolean,
              onChanged: funcion,
            ),
          ),
          Text(description),
        ],
      );
}
