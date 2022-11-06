import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../model/proyecto_Model.dart';
import '../../System/ProfileConstant.dart';
import '../ReportPages/listreportes.dart';
import '../ReportPages/newReport.dart';

class proyectodetalle extends StatefulWidget {
  final ProyectoModel proyectoModel;

  const proyectodetalle(this.proyectoModel, {super.key});

  @override
  State<proyectodetalle> createState() => _proyectodetalleState();
}

class _proyectodetalleState extends State<proyectodetalle> {
  List<String> ImagenesURLs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<ListResult> archivo = FirebaseStorage.instance
        .ref('/reportes')
        .child(widget.proyectoModel.dni.toString())
        .listAll();
    archivo.then((value) {
      value.items.forEach((element) async {
        ImagenesURLs.add(await DownloadFile(element));
        setState(() {});
      });
    });
  }

  Future<String> DownloadFile(Reference ref) async {
    final URL = await ref.getDownloadURL();
    return URL;
  }

  List<Widget> generateImages() {
    return ImagenesURLs.map((element) => ClipRRect(
          child: Image.network(
            element,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15.0),
        )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Barra
      appBar: defaultAppBarBack,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(defaultShortPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Botón Nuevo Reporte
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              newreport(widget.proyectoModel)));
                },
                child: Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 20),
                            blurRadius: 30.0,
                            color: Colors.black12)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: 100.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 12.0),
                        child: Text(
                          'Nuevo Reporte',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.apply(color: Colors.black),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(95.0),
                                topLeft: Radius.circular(95.0),
                                bottomRight: Radius.circular(200.0))),
                      ),
                      Icon(
                        Icons.article_outlined,
                        size: 30.0,
                      )
                    ],
                  ),
                ),
              ),
              //Botón Historial de Reportes
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            listreportes(widget.proyectoModel))),
                child: Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 20),
                            blurRadius: 30.0,
                            color: Colors.black12)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: 100.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 12.0),
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(95.0),
                                topLeft: Radius.circular(95.0),
                                bottomRight: Radius.circular(200.0))),
                        child: Text(
                          'Historial de Reportes',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.apply(color: Colors.black),
                        ),
                      ),
                      const Icon(
                        Icons.amp_stories_outlined,
                        size: 30.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Imagen
            Column(
              children: [
                ImagenesURLs.isNotEmpty
                    ? Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        color: Color(0xFFFAFAFA),
                        elevation: 0,
                        child: CarouselSlider(
                          items: generateImages(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            aspectRatio: 1,
                            viewportFraction: 1,
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultPadding, 5.0, defaultPadding, 0.0),
                  child: Text(
                    "Dirección: ${widget.proyectoModel.address}",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            //DETALLES DEL PROYECTO
            Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding,
                  defaultPadding, defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 3),
                  topRight: Radius.circular(defaultBorderRadius * 3),
                ),
              ),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "DETALLES DEL PROYECTO",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  _RowConstant(
                      'Beneficiario:', "${widget.proyectoModel.beneficiario}"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('DNI:', "${widget.proyectoModel.dni}"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Teléfono:', "${widget.proyectoModel.telefono}"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant(
                      'Contrato:', "${widget.proyectoModel.codProyecto}"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Módulo:', "${widget.proyectoModel.modulo}"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant(
                      'Coordenadas:', "${widget.proyectoModel.coordenadas}"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant(
                      'Departamento:', "${widget.proyectoModel.departamento}"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant(
                      'Provincia:', "${widget.proyectoModel.provincia}"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Distrito:', "${widget.proyectoModel.distrito}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_RowConstant(String title, String content) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        content,
        style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.fade),
      ),
    ],
  );
}
