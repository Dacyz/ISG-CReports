import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? role;

  UserModel({this.uid, this.role});

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot["uid"],
      role: snapshot["role"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "role": role,
      };
}
