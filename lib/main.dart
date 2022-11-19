import 'package:flutter/material.dart';
import 'package:insergemobileapplication/controller/usermanagement.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';

import 'view/System/Start/StartPage.dart';

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
      themeMode: ThemeMode.system,
      darkTheme: ThemesConstants.darkTheme,
      theme: ThemesConstants.lightTheme,
      home: FutureBuilder(
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              return UserManagement().handleAuth();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: UserManagement().initializeFirebase()),
    );
  }
}
