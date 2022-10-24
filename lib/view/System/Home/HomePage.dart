import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Pages/MainPages/EntityChatPage.dart';
import '../../Pages/MainPages/MyReportsPage.dart';
import '../../Pages/MainPages/StartPage.dart';

class StartHomePage extends StatefulWidget {
  const StartHomePage({super.key});

  @override
  State<StartHomePage> createState() => _StartHomePageState();
}

class _StartHomePageState extends State<StartHomePage> {
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
      icon: Icon(Icons.messenger_outline_rounded),
      label: 'Chat',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 16 / 2),
            Text(
              "Piura 2022",
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              /*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPage(),
                ),
              );*/
            },
            icon: Icon(Icons.person_outline_rounded),
            color: Colors.blue,
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: ((value) {
          setState(() {
            _selectedIndex = value;
          });
        }),
        children: const [
          MyReportsPage(),
          StartPage(),
          EntityChatPage(),
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
    );
  }
}
