import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/proyecto_Model.dart';

mixin Proyecto_helper {
  static Stream<List<ProyectoModel>> read() {
    final proyectoCollection =
        FirebaseFirestore.instance.collection("proyectos");
    return proyectoCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ProyectoModel.fromSnapshot(e)).toList());
  }
}
