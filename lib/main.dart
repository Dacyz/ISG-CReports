import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inserge Application Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login(),
                        ),
                      );*/
                    },
                    child: const Text("Iniciar Sesión",
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
                SizedBox(height: 16),
                //Bton Ingresar
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaginaSettings(),
                        ),
                      );*/
                    },
                    child: const Text("Catálogo",
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
              ],
            ),
          )),
        ),
      ),
    );
  }
}
