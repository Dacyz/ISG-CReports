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
          crossAxisAlignment: CrossAxisAlignment.center,
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
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultBorderRadius)),
              fillColor: Colors.blueAccent,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  "Iniciar Sesión",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultBorderRadius)),
              fillColor: Colors.blueAccent,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VisualizatorPage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  "Catálogo",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
