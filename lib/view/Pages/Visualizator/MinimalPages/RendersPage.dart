import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import '../../../System/ProfileConstant.dart';

class RendersPage extends StatefulWidget {
  const RendersPage({Key? key}) : super(key: key);

  @override
  State<RendersPage> createState() => _RendersPageState();
}

class _RendersPageState extends State<RendersPage> {
  late UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;
  bool movementX = true;
  bool movementY = false;
  bool wallsVisibility = false;
  int listModulsIndex = 0;
  int listPersonIndex = 0;

  final List<List<String>> _listModuls = [
    ["3 metros", "Descripcion del modulo 3"],
    ["4 metros", "Descripcion del modulo 4"],
    ["5 metros", "Descripcion del modulo 5"],
    ["6 metros", "Descripcion del modulo 6"],
    ["7 metros", "Descripcion del modulo 7"]
  ];

  final List<String> _listPersons = [
    "",
    "Kid",
    "Adult",
    "Woman",
  ];

  void defaultValues() {
    _sliderValue = 0.0;
    movementX = true;
    movementY = false;
    wallsVisibility = false;
    listPersonIndex = 0;
  }

  @override
  void initState() {
    defaultValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 350,
                child: Stack(
                  children: <Widget>[
                    UnityWidget(
                      onUnityCreated: onUnityCreated,
                      onUnityMessage: onUnityMessage,
                      fullscreen: false,
                    ),
                    Positioned(
                      bottom: 40,
                      right: 20,
                      child: Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                iconModify(
                                  icono: Icon(
                                    Icons.close,
                                    color:
                                        movementX ? Colors.green : Colors.black,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      movementX = movementX ? false : true;
                                    });
                                    setMovementX(movementX.toString());
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                iconModify(
                                  icono: Icon(
                                    Icons.currency_yuan,
                                    color:
                                        movementY ? Colors.green : Colors.black,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      movementY = movementY ? false : true;
                                    });
                                    setMovementY(movementY.toString());
                                  },
                                ),
                              ],
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 20,
                      child: Card(
                        elevation: 2,
                        child: Row(
                          children: [
                            iconModify(
                              icono: Icon(
                                wallsVisibility
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                                color: wallsVisibility
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              onTap: () {
                                wallsVisibility =
                                    wallsVisibility ? false : true;
                                setState(() {});
                                setWallsVisibility(wallsVisibility.toString());
                              },
                            ),
                            iconModify(
                              icono: Icon(
                                _listPersons[listPersonIndex] == ""
                                    ? Icons.person_off
                                    : _listPersons[listPersonIndex] == "Kid"
                                        ? Icons.smart_toy_rounded
                                        : _listPersons[listPersonIndex] ==
                                                "Adult"
                                            ? Icons.boy_rounded
                                            : Icons.woman,
                                color: Colors.black,
                              ),
                              onTap: () {
                                if (listPersonIndex ==
                                    _listPersons.length - 1) {
                                  listPersonIndex = 0;
                                } else {
                                  listPersonIndex++;
                                }
                                setState(() {});
                                setPersonVisibility('');
                              },
                            ),
                            Container(
                              color: Colors.white,
                              height: 25,
                              width: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding:  EdgeInsets.only(top: 10),
                      child: Text(
                          "Velocidad de Rotación"),
                    ),
                    Slider(
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                        setRotationSpeed(value.toStringAsFixed(3));
                      },
                      value: _sliderValue,
                      min: 0.000,
                      max: 0.010,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    labelModify(
                      icono: const Icon(Icons.arrow_left),
                      onTap: () {
                        if (listModulsIndex != 0) {
                          listModulsIndex--;
                          PreviusModule();
                          defaultValues();
                          setState(() {});
                        }
                      },
                    ),
                    Text("Modulo de ${_listModuls[listModulsIndex][0]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        )),
                    labelModify(
                      icono: const Icon(Icons.arrow_right),
                      onTap: () {
                        if (listModulsIndex != _listModuls.length - 1) {
                          listModulsIndex++;
                          NextModule();
                          defaultValues();
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(_listModuls[listModulsIndex][1],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Communcation from Flutter to Unity
  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Rotation',
      'SetRotationSpeed',
      speed,
    );
  }

  // Communcation from Flutter to Unity
  void setMovementX(String bool) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetMovementX',
      bool,
    );
  }

  // Communcation from Flutter to Unity
  void setMovementY(String bool) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetMovementY',
      bool,
    );
  }

  // Communcation from Flutter to Unity
  void setWallsVisibility(String bool) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetWallsVisibility',
      bool,
    );
  }

  // Communcation from Flutter to Unity
  void setPersonVisibility(String bool) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetPersonVisibility',
      bool,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo.name}');
    print(
        'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
  }

  void NextModule() {
    _unityWidgetController.postMessage(
      'Cube',
      'NextModule',
      '',
    );
  }

  void PreviusModule() {
    _unityWidgetController.postMessage(
      'Cube',
      'PreviusModule',
      '',
    );
  }
}
