import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/reportes_Model.dart';

class Reportes_helper {
  static Stream<List<ReportesModel>> read(String id) {
    final reportesCollection = FirebaseFirestore.instance
        .collection("proyectos")
        .doc(id)
        .collection("reportes").orderBy("fecharegistro",descending: true);
    return reportesCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ReportesModel.fromSnapshot(e)).toList());
  }

  static Future create(ReportesModel report, String id) async {
    final reportesCollection = FirebaseFirestore.instance
        .collection("proyectos")
        .doc(id)
        .collection("reportes");
    final docref = reportesCollection.doc();
    final newReport = ReportesModel(
      estado: report.estado,
      fecharegistro: report.fecharegistro,
      preguntaone: report.preguntaone,
      preguntatwo: report.preguntatwo,
      preguntathree: report.preguntathree,
      observacion: report.observacion,
      url: report.url,
    ).toJson();
    try {
      await docref.set(newReport);
      return docref;
    } catch (e) {
      print("ocurrio un error $e");
    }
  }
}
