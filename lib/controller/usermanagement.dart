import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/model/user_model.dart';
import 'package:insergemobileapplication/view/System/Home/HomePage.dart';
import 'package:insergemobileapplication/view/System/Start/StartPage.dart';

import '../view/System/ProfileConstant.dart';

class UserManagement {
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> loginUsingPass(
      {required String userd,
      required String pass,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: userd, password: pass);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {}
    }
    return user;
  }

  Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/icons/InsergeSVGM.svg",
                  color: Colors.blueAccent,
                ),
                const CircularProgressIndicator(),
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          UserManagement.readUserProperties().then((value) {
            UsuarioGlobal = UserModel.fromSnapshot(value.docs[0]);
            print(UsuarioGlobal.area);
          });
          return StartHomePage(user: FirebaseAuth.instance.currentUser!);
        }
        return const StartPage();
      },
    );
  }

  static readUserProperties() {
    var user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection("/users")
        .where('uid', isEqualTo: user?.uid)
        .get();
  }

  static updateUserDescription(String description) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      QuerySnapshot asd = await FirebaseFirestore.instance
          .collection("/users")
          .where('uid', isEqualTo: user?.uid)
          .get();
      await asd.docs[0].reference.update({"descripcion": description});
      return true;
    } catch (e) {
      return false;
    }
  }

  signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Sesión cerrada"),
    ));
  }
}
