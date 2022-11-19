import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../model/proyecto_Model.dart';
import '../../System/ProfileConstant.dart';
import '../ReportPages/ListReportPage.dart';
import '../ReportPages/NewReportPage.dart';

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Botón Nuevo Reporte
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => newreport(widget.proyectoModel)));
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
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(95.0),
                              topLeft: Radius.circular(95.0),
                              bottomRight: Radius.circular(200.0))),
                      child: Text(
                        'Nuevo Reporte',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.apply(color: Colors.black),
                      ),
                    ),
                    const Icon(
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //Imagen
            Column(
              children: [
                ImagenesURLs.isNotEmpty
                    ? Card(
                        shape: const RoundedRectangleBorder(
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
                    : const SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(
                              'Aún no hay fotografias en los reportes para mostrar'),
                        ),
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  defaultPadding, 5.0, defaultPadding, 0.0),
              child: Text(
                "Dirección: ${widget.proyectoModel.address}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            //DETALLES DEL PROYECTO
            Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding,
                  defaultPadding, defaultPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
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
                  const SizedBox(height: defaultShortPadding),
                  _RowConstant('DNI:', "${widget.proyectoModel.dni}"),
                  const SizedBox(height: defaultShortPadding),
                  _RowConstant('Teléfono:', "${widget.proyectoModel.telefono}"),
                  const SizedBox(height: defaultShortPadding),
                  _RowConstant(
                      'Contrato:', "${widget.proyectoModel.codProyecto}"),
                  const SizedBox(height: defaultShortPadding),
                  _RowConstant('Módulo:', "${widget.proyectoModel.modulo}"),
                  const SizedBox(height: defaultShortPadding),
                  _RowConstant(
                      'Coordenadas:', "${widget.proyectoModel.coordenadas}"),
                  const SizedBox(height: defaultShortPadding),
                  _RowConstant(
                      'Departamento:', "${widget.proyectoModel.departamento}"),
                  const SizedBox(height: defaultShortPadding),
                  _RowConstant(
                      'Provincia:', "${widget.proyectoModel.provincia}"),
                  const SizedBox(height: defaultShortPadding),
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

_RowConstant(String title, String content) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          content,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.fade),
        ),
      ],
    );
