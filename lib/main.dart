import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';

import 'view/Pages/StatusPages/Visualizator/VisualizatorPage.dart';
import 'view/System/Start/login.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
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
        const SizedBox(height: defaultPadding * 2),
        ElevatedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => login(),
              ),
            );
          },
          child: const Text("Iniciar Sesión",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              )),
          style: ElevatedButton.styleFrom(
            primary: Color(0x03E9F4),
            padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 14),
            side: BorderSide(color: Color(0xFF084460)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.lightBlue,
          ),
        ),
        const SizedBox(height: defaultPadding),
        ElevatedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VisualizatorPage(),
              ),
            );
          },
          child: const Text("Catálogo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              )),
          style: ElevatedButton.styleFrom(
            primary: Color(0x03E9F4),
            padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 14),
            side: BorderSide(color: Color(0xFF084460)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.lightBlue,
          ),
        ),
      ],
    )));
  }
}
