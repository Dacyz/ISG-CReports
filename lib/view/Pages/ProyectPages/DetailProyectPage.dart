import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../model/proyecto_Model.dart';
import '../../System/ProfileConstant.dart';
import '../ReportPages/ListReportPage.dart';
import '../ReportPages/NewReportPage.dart';

class DetailProyectPage extends StatefulWidget {
  final ProyectoModel proyectoModel;

  const DetailProyectPage(this.proyectoModel, {super.key});

  @override
  State<DetailProyectPage> createState() => _DetailProyectPageState();
}

class _DetailProyectPageState extends State<DetailProyectPage> {
  List<String> imagenesURLs = [];

  @override
  void initState() {
    super.initState();
    _chargeData();
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
                        builder: (context) =>
                            NewReportPage(widget.proyectoModel)));
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
                    builder: (context) => ListReportPage(widget.proyectoModel)),
              ),
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //Imagen
            Column(
              children: [
                imagenesURLs.isNotEmpty
                    ? Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        color: const Color(0xFFFAFAFA),
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
                  _rowConstant(
                      'Beneficiario:', "${widget.proyectoModel.beneficiario}"),
                  const SizedBox(height: defaultShortPadding),
                  _rowConstant('DNI:', "${widget.proyectoModel.dni}"),
                  const SizedBox(height: defaultShortPadding),
                  _rowConstant('Teléfono:', "${widget.proyectoModel.telefono}"),
                  const SizedBox(height: defaultShortPadding),
                  _rowConstant(
                      'Contrato:', "${widget.proyectoModel.codProyecto}"),
                  const SizedBox(height: defaultShortPadding),
                  _rowConstant('Módulo:', "${widget.proyectoModel.modulo}"),
                  const SizedBox(height: defaultShortPadding),
                  _rowConstant(
                      'Coordenadas:', "${widget.proyectoModel.coordenadas}"),
                  const SizedBox(height: defaultShortPadding),
                  _rowConstant(
                      'Departamento:', "${widget.proyectoModel.departamento}"),
                  const SizedBox(height: defaultShortPadding),
                  _rowConstant(
                      'Provincia:', "${widget.proyectoModel.provincia}"),
                  const SizedBox(height: defaultShortPadding),
                  _rowConstant('Distrito:', "${widget.proyectoModel.distrito}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _chargeData() {
    Future<ListResult> archivo = FirebaseStorage.instance
        .ref('/reportes')
        .child(widget.proyectoModel.dni.toString())
        .listAll();
    archivo.then((value) {
      value.items.forEach((element) async {
        imagenesURLs.add(await downloadFile(element));
        setState(() {});
      });
    });
  }

  Future<String> downloadFile(Reference ref) async {
    final String url = await ref.getDownloadURL();
    return url;
  }

  List<Widget> generateImages() {
    return imagenesURLs
        .map((element) => ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                element,
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }

  _rowConstant(String title, String content) => Row(
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
}
