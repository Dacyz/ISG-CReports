import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? descripcion;
  final String? role;
  final int? sesiones;
  final String? cargo;
  final String? area;

  UserModel(
      {this.descripcion,
      this.sesiones,
      this.cargo,
      this.area,
      this.uid,
      this.role});

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        uid: snapshot["uid"],
        descripcion: snapshot["descripcion"],
        role: snapshot["role"],
        sesiones: snapshot["sesiones"],
        cargo: snapshot["cargo"],
        area: snapshot["area"]);
  }

  Map<String, dynamic> toUpdateDescriptionJson() =>
      {"descripcion": descripcion};

  Map<String, dynamic> toUpdateSesionsJson() => {"sesiones": sesiones};
}
