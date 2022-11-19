import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insergemobileapplication/model/user_model.dart';
import 'package:insergemobileapplication/view/System/Home/HomePage.dart';
import 'package:insergemobileapplication/view/System/Start/LoginPage.dart';
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          UserManagement.readUserProperties().then((value) {
            UsuarioGlobal = UserModel.fromSnapshot(value.docs[0]);
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

  signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Sesión cerrada"),
    ));
  }
}
