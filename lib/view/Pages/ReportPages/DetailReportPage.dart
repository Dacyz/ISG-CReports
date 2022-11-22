import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../../model/reportes_Model.dart';
import '../../System/ProfileConstant.dart';

class DetailReportPage extends StatefulWidget {
  final ReportesModel reporteModel;

  const DetailReportPage(this.reporteModel, {super.key});

  @override
  State<DetailReportPage> createState() => _DetailReportPageState();
}

class _DetailReportPageState extends State<DetailReportPage> {
  late String _estadoString;
  late String _observacionString;
  late String _fechaString;
  late String _horaString;
  late String _preguntaUnoString;
  late String _preguntaDosString;
  late String _preguntaTresString;

  List<Widget> generateImages() {
    return widget.reporteModel.url!
        .map((element) => ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                element,
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }

  @override
  void initState() {
    _chargeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarTitle('Reportes'),
      body: Column(
        children: [
          //Card con Imagen
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
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
              ),
            ),
          ),
          //Card Detalle
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Center(
                        child: Text(
                      "Detalle de reporte",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
                    IconButton(
                        icon: const Icon(Icons.content_copy),
                        onPressed: () async {
                          await FlutterClipboard.copy(
                              "$_estadoString\n$_observacionString\n$_fechaString\n$_horaString\n$_preguntaUnoString\n$_preguntaDosString\n$_preguntaTresString");
                          ScaffoldMessenger.of(this.context)
                              .showSnackBar(const SnackBar(
                            content: Text("Copiado correctamente"),
                          ));
                        })
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "Estado: ${_estado()}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "Observacion: ${widget.reporteModel.observacion}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "Fecha: ${widget.reporteModel.fecharegistro?.day}/${widget.reporteModel.fecharegistro?.month}/${widget.reporteModel.fecharegistro?.year}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "Hora: ${widget.reporteModel.fecharegistro?.hour}:${widget.reporteModel.fecharegistro?.minute}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "${_preguntaone()}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "${_preguntatwo()}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "${_preguntathree()}",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _chargeData() {
    _estadoString = "Estado:  " "${_estado()}";
    _observacionString = "Observacion: ${widget.reporteModel.observacion}";
    _fechaString =
        "Fecha: ${widget.reporteModel.fecharegistro?.day}/${widget.reporteModel.fecharegistro?.month}/${widget.reporteModel.fecharegistro?.year}";
    _horaString =
        "Hora: ${widget.reporteModel.fecharegistro?.hour}:${widget.reporteModel.fecharegistro?.minute}";
    _preguntaUnoString = "${_preguntaone()}";
    _preguntaDosString = "${_preguntatwo()}";
    _preguntaTresString = "${_preguntathree()}";
  }

  _estado() {
    switch (widget.reporteModel.estado) {
      case 1:
        return "Entrega de Materiales.";
      case 2:
        return "Ubicación y limpieza de terreno.";
      case 3:
        return "Trazo y excavación de zanjas para cimiento.";
      case 4:
        return "Armado de columnas.";
      case 5:
        return "Vaciado de cimientos.";
      case 6:
        return "Armado y vaciado de sobrecimiento.";
      case 7:
        return "Asentado de ladrillos.";
      case 8:
        return "Vaciado de Columna.";
      case 9:
        return "Acero de techo y encofrado.";
      default:
        return "Error al seleccionar.";
    }
  }

  _preguntaone() {
    switch (widget.reporteModel.preguntaone) {
      case true:
        return "Si se encontraba el Beneficiario.";
      case false:
        return "No se encontraba el beneficiario.";
      default:
        return "Error al seleccionar.";
    }
  }

  _preguntatwo() {
    switch (widget.reporteModel.preguntatwo) {
      case true:
        return "Si se encontraba el maestro a cargo.";
      case false:
        return "No se encontraba el maestro a cargo.";
      default:
        return "Error al seleccionar.";
    }
  }

  _preguntathree() {
    switch (widget.reporteModel.preguntathree) {
      case true:
        return "Si se encontraban los obreros trabajando.";
      case false:
        return "No se encontraban los obreros trabajando.";
      default:
        return "Error al seleccionar.";
    }
  }
}
