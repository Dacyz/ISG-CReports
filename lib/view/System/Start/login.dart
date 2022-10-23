import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class login extends StatelessWidget {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF101A26),
            Color(0xFF111C28),
            Color(0xFF101B27)
          ]),
        ),
        child: SafeArea(
          child: Center(
              child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: SvgPicture.asset(
                    "assets/icons/InsergeSVGM.svg",
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                //Usuario
                Padding(
                  padding: const EdgeInsets.only(right: 23),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: TextFormField(
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                        decoration: const InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFFC4B08), width: 2),
                            ),
                            icon: Icon(
                              Icons.perm_identity,
                              color: Color(0xFFFFFFFF),
                            ),
                            labelText: "Usuario",
                            labelStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 23),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: TextFormField(
                        obscureText: !_isVisible,
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              _isVisible = !_isVisible;
                              (context as Element).markNeedsBuild();
                            },
                            icon: _isVisible
                                ? Icon(
                                    Icons.visibility,
                                    color: Color(0xFFFC4B08),
                                    size: 17,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Color(0xFFFFFFFF),
                                    size: 17,
                                  ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFFC4B08), width: 2),
                          ),
                          icon: Icon(
                            Icons.password,
                            color: Color(0xFFFFFFFF),
                          ),
                          labelText: "Contraseña",
                          labelStyle: TextStyle(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),

                //Bton Ingresar
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  HomePage(),
                            ),
                          );*/
                    },
                    child: const Text("Ingresar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        )),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0x03E9F4),
                      padding:
                          EdgeInsets.symmetric(horizontal: 70.0, vertical: 14),
                      side: BorderSide(color: Color(0xFF084460)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      shadowColor: Colors.lightBlue,
                    ),
                  ),
                ),

                SizedBox(height: 20),
                //No puedo acceder--contactar con genrente
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿Problemas al acceder?",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFFFFF))),
                    Text(
                      "  Contactanos",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
