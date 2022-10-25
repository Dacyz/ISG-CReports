import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel{

  final String? username;
  final String? contra;

  UserModel({this.username, this.contra});

  factory UserModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      username: snapshot["username"],
      contra:  snapshot["contrasena"]
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "contrasena": contra,
  };
}