import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/view/System/Start/login.dart';

import '../../Pages/MainPages/EntityChatPage.dart';
import '../../Pages/MainPages/MyReportsPage.dart';
import '../../Pages/MainPages/StartPage.dart';
import '../ProfileConstant.dart';

class StartHomePage extends StatefulWidget {
  final User user;
  StartHomePage({super.key, required this.user});

  @override
  State<StartHomePage> createState() => _StartHomePageState(usuario: user);
}

class _StartHomePageState extends State<StartHomePage> {
  final User usuario;
  _StartHomePageState({required this.usuario});

  int _selectedIndex = 1;
  final PageController _pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

  final _PageList = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.file_present_outlined),
      label: 'Mis reportes',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Inicio',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Person',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemStatusBarContrastEnforced: true));
    return WillPopScope(
      onWillPop: () {
        _onWillPopScope(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: defaultAppBar,
        body: PageView(
          controller: _pageController,
          onPageChanged: ((value) {
            setState(() {
              _selectedIndex = value;
            });
          }),
          children: [
            const MyReportsPage(),
            const StartPage(),
            EntityChatPage(user: usuario),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _PageList,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 250),
              curve: Curves.easeIn,
            );
          },
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }

  void _onWillPopScope(BuildContext context) async {
    if (_selectedIndex == 1) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Salir"),
            content: const Text("¿Seguro que quieres cerrar sesión?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                },
                child: const Text("Sí"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              )
            ],
          );
        },
      );
    } else {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }
}
