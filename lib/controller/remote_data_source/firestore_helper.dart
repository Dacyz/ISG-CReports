import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class FirestoreHelper {
  static Stream<List<UserModel>> read() {
    final userCollection = FirebaseFirestore.instance.collection("users");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  static Future create(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("users");
    final docref = userCollection.doc();
    final newUser = UserModel(
      username: user.username,
      contra: user.contra,
    ).toJson();
    try {
      await docref.set(newUser);
    } catch (e) {
      print("ocurrio un error $e");
    }
  }
}
