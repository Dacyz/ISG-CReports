import 'package:cloud_firestore/cloud_firestore.dart';

class ReportesModel {
  final String? ide;
  late final int? estado;
  late final DateTime? fecharegistro;
  final bool? preguntaone;
  final bool? preguntatwo;
  final bool? preguntathree;
  final String? observacion;
  late List<dynamic>? url;

  ReportesModel({
    this.ide,
    this.estado,
    this.fecharegistro,
    this.preguntaone,
    this.preguntatwo,
    this.preguntathree,
    this.observacion,
    this.url,
  });

  factory ReportesModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ReportesModel(
      ide: snap.reference.id,
      estado: snapshot["estado"],
      fecharegistro: (snapshot["fecharegistro"] as Timestamp).toDate(),
      preguntaone: snapshot["preguntaone"],
      preguntatwo: snapshot["preguntatwo"],
      preguntathree: snapshot["preguntathree"],
      observacion: snapshot["observacion"],
      url: snapshot["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "fecharegistro": fecharegistro,
        "preguntaone": preguntaone,
        "preguntatwo": preguntatwo,
        "preguntathree": preguntathree,
        "observacion": observacion,
        "url": url,
      };
}
