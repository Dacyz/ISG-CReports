import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/model/user_model.dart';

//Diapositivos como Tables:
extension ContextExtension on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.shortestSide > 600;
}

class ThemesConstants {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(
      primary: Colors.orange,
      secondary: Colors.blue,
      onError: Colors.redAccent,
    ),
    primaryColor: Colors.blueAccent,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
    ),
    shadowColor: Colors.white.withOpacity(0.1),
    cardColor: Colors.black26,
    hoverColor: Colors.orange,
    dialogBackgroundColor: Colors.black26,
    unselectedWidgetColor: Colors.white60,
    focusColor: Colors.orange,
  );
  static final lightTheme = ThemeData(
    shadowColor: Colors.grey.withOpacity(0.5),
    colorScheme: const ColorScheme.light(
      primary: Colors.orange,
      secondary: Colors.blueAccent,
      onError: Colors.redAccent,
    ),
    appBarTheme:
        const AppBarTheme(color: Colors.black, foregroundColor: Colors.black),
    cardColor: Colors.white,
    primaryColor: Colors.blueAccent,
    unselectedWidgetColor: Colors.black45,
    focusColor: Colors.orange,
  );
}

//Propiedades
const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
  borderSide: BorderSide.none,
);

//Propiedades de Widgets predeterminadas
BoxDecoration defaultBoxDecoration(Color colorBackground, Color shadowColor) {
  return BoxDecoration(
    color: colorBackground,
    borderRadius: BorderRadius.circular(defaultBorderRadius),
    boxShadow: defaultBoxShadow(shadowColor),
  );
}

List<BoxShadow> defaultBoxShadow(Color shadowColor) {
  return [
    BoxShadow(
      color: shadowColor,
      spreadRadius: 1,
      blurRadius: 2,
      offset: Offset(0, 2), // changes position of shadow
    )
  ];
}

UserModel UsuarioGlobal = UserModel();

//Variables
const Color primaryHColor = Colors.indigo;
const Color primaryColor = Colors.blueAccent;
const Color secondColor = Colors.orange;
const Color bgColor = Colors.white;

const double defaultLargePadding = 20.0;
const double defaultPadding = 16.0;
const double defaultShortPadding = 8.0;
const double defaultMiniPadding = 4.0;
const double defaultBorderRadius = 12.0;

GestureDetector Miau = GestureDetector(
  onTap: () {},
  child: Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.search_outlined),
        ),
        Text(
          "Buscar...",
          style: TextStyle(color: Colors.black54),
        )
      ],
    ),
  ),
);

AppBar defaultAppBar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: Padding(
    padding: const EdgeInsets.all(8.0),
    child: SvgPicture.asset(
      "assets/icons/InsergeSVGM.svg",
      color: Colors.blueAccent,
    ),
  ),
  title: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: const [
      Text(
        "Piura, 2022",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ],
  ),
);

AppBar defaultAppBarTitle(String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        "assets/icons/InsergeSVGM.svg",
        color: Colors.blueAccent,
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    ),
  );
}

AppBar defaultAppBarBack = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const Text(
        "Piura, 2022",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(
        width: 40,
        height: 30,
        child: ClipRRect(
          child: SvgPicture.asset(
            "assets/icons/InsergeSVGM.svg",
            color: Colors.blueAccent,
          ),
        ),
      ),
    ],
  ),
);

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

Widget labelModify({
  required Icon icono,
  VoidCallback? onTap,
}) {
  return InkWell(
      onTap: onTap,
      child: Center(
        child: icono,
      ));
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
          onTap: onTap,
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
