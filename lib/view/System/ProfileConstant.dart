import 'package:flutter/material.dart';

//Diapositivos como Tables:
extension ContextExtension on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.shortestSide > 600;
}

//Variables
const Color primaryColor = Colors.blueAccent;
const Color secondColor = Colors.orange;
const Color bgColor = Colors.white;

const double defaultPadding = 16.0;
const double defaultShortPadding = 8.0;
const double defaultLargePadding = 20.0;
const double defaultBorderRadius = 12.0;

//Propiedades
const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
  borderSide: BorderSide.none,
);

//Propiedades de Widgets predeterminadas
BoxDecoration defaultBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  boxShadow: defaultBoxShadow,
);

List<BoxShadow> defaultBoxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 2,
    offset: const Offset(0, 2), // changes position of shadow
  )
];

Widget iconModify({
  required Icon icono,
  VoidCallback? onTap,
}) {
  return Container(
    child: Material(
      child: InkWell(
          onTap: onTap,
          child: Center(
            child: icono,
          )),
    ),
  );
}

Widget buttonModify({
  required String Action,
  VoidCallback? onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    width: 150,
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blue.shade50,
          Colors.blue.shade50,
          Colors.blueAccent.shade100,
        ],
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {},
          child: Center(
            child: Text(Action,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                )),
          )),
    ),
  );
}
