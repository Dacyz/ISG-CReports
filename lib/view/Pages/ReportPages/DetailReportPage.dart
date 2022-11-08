import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/reportes_Model.dart';
import '../../System/ProfileConstant.dart';

class reportedetalle extends StatefulWidget {
  final ReportesModel reporteModel;

  reportedetalle(this.reporteModel);

  @override
  State<reportedetalle> createState() => _reportedetalleState();
}

class _reportedetalleState extends State<reportedetalle> {
  List<Widget> generateImages() {
    return widget.reporteModel.url!
        .map((element) => ClipRRect(
              child: Image.network(
                element,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarTitle('Reportes'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            //Card con Imagen
            Container(
              padding: EdgeInsets.all(12),
              width: 360,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xFFFFFFFF),
                //Color(0xFFFFFFFF),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
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
                ),
              ),
            ),
            //Card Detalle
            SizedBox(
              width: 350,
              height: 330,
              child: Card(
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                            child: Text(
                          "DETALLE DEL PROYECTO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                        SizedBox(
                          height: 17,
                        ),
                        Text(
                          "Estado:  " "${_estado()}",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Observacion:  " +
                              "${widget.reporteModel.observacion}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _estado() {
    switch (widget.reporteModel.estado) {
      case 1:
        return "Entrega de Materiales";
      case 2:
        return "Ubicación y limpieza de terreno";
      case 3:
        return "Trazo y excavación de zanjas para cimiento";
      case 4:
        return "Armado de columnas";
      case 5:
        return "xd";
      case 6:
        return "Armado y vaciado de sobrecimiento";
      case 7:
        return "Asentado de ladrillos";
      case 8:
        return "Vaciado de Columna";
      case 9:
        return "Acero de techo y encofrado";
      default:
        return "Error al seleccionar";
    }
  }
}
