import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';

import '../Home/HomePage.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  Future<FirebaseApp> _initializeFirebase() async {
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
      if (e.code == "user-not-found") {
        print(e);
      }
    }
    return user;
  }

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              return SafeArea(
                child: Center(
                    child: SingleChildScrollView(
                  reverse: true,
                  padding: const EdgeInsets.all(defaultPadding / 2),
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
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: "Correo Institucional",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(height: defaultPadding),
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isVisible,
                          decoration: InputDecoration(
                              hintText: "Contraseña",
                              prefixIcon: const Icon(
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
                        const SizedBox(height: defaultPadding * 2),
                        RawMaterialButton(
                          fillColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius)),
                          onPressed: () async {
                            //// Comentado para entrar de una XD
                            /* 
                            User? user = await loginUsingPass(
                                userd: _emailController.text,
                                pass: _passwordController.text,
                                context: context);
                            if (user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartHomePage(),
                                ),
                              );
                            } else {
                              print('Usuario incorrecto');
                            }*/
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StartHomePage(),
                              ),
                            );
                          },
                          child: const Text("Ingresar",
                              style: TextStyle(
                                color: Colors.white,
                              )),
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
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: _initializeFirebase()),
    );
  }
}
