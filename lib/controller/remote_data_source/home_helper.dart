import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/proyecto_Model.dart';

mixin LastObject_helper {
  static Future<Stream<List<ProyectoModel>>> getLastProyect() async {
    final proyectoCollection = FirebaseFirestore.instance
        .collection("proyectos")
        .orderBy('codiproyecto', descending: true)
        .limit(1);

    proyectoCollection.get();

    var aaaa = proyectoCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ProyectoModel.fromSnapshot(e)).toList());
    return aaaa;
  }

  static Future<Stream<List<ProyectoModel>>> getCountProyects() async {
    final proyectoCollection = FirebaseFirestore.instance
        .collection("proyectos")
        .orderBy('codiproyecto', descending: true)
        .count()
        .query;

    var aaaa = proyectoCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ProyectoModel.fromSnapshot(e)).toList());
    return aaaa;
  }

  static countDocuments() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection('proyectos').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length; // Count of Documents in Collection
  }
}
