import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';

import '../Home/HomePage.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  static Future<User?> loginUsingPass(
      {required String userd,
      required String pass,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: userd, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No se encontraron usuarios");
      }
    }
  }

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: SvgPicture.asset(
                    "assets/icons/InsergeSVGM.svg",
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                //Usuario
                Container(
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Correo Institucional",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        )),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Container(
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !_isVisible,
                    decoration: InputDecoration(
                        hintText: "Contraseña",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _isVisible
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye_rounded,
                            color: Colors.black,
                          ),
                          onTap: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                        )),
                  ),
                ),
                const SizedBox(height: defaultPadding * 2),
                Container(
                  child: RawMaterialButton(
                    fillColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius)),
                    onPressed: () async {
                      User? user = await loginUsingPass(
                          userd: _emailController.text,
                          pass: _passwordController.text,
                          context: context);
                      print(_emailController.text + _passwordController.text);
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartHomePage(),
                          ),
                        );
                      } else {
                        print('Usuario incorrecto');
                      }
                    },
                    child: const Text("Ingresar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("¿Problemas al acceder?",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      "  Contactanos",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
