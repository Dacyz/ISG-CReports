import 'package:flutter/material.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(defaultShortPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Inserge Movil - Copyright'),
            Icon(Icons.copyright)
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Image.asset('assets/icons/logo-inserge.png'),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text(
                    'Información de contacto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(defaultLargePadding),
                  child: Text(
                    'La empresa Ingenieria y Servicios Generales Piura S.A.C. pone a dispocición estos canales de servicio para el contacto con sus principales representantes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultLargePadding,
                      vertical: defaultShortPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Telefono',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(),
                      Text(
                        '+51 923 206 089',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultLargePadding,
                      vertical: defaultShortPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Correo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(),
                      Text(
                        'Insergepiurasac@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
