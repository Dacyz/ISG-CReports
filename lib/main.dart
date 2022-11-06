import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';

import 'view/Pages/Visualizator/VisualizatorPage.dart';
import 'view/System/Start/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.blueAccent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inserge Application Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: SvgPicture.asset(
                        "assets/icons/InsergeSVGM.svg",
                        color: Colors.blueAccent,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(defaultLargePadding),
              child: Text(
                'Inserge - Piura',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultLargePadding),
              child: Text(
                'Ingenieria y Servicios Generales Piura S.A.C.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            const Text(
              'Elige lo que gustas ver...',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: defaultLargePadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: RawMaterialButton(
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
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: RawMaterialButton(
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
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Catálogo",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '¿Qué hago aquí?',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                SizedBox(width: defaultShortPadding),
                Text(
                  'Más información...',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.blueGrey),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.link,
                  color: Colors.blueGrey,
                )
              ],
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
