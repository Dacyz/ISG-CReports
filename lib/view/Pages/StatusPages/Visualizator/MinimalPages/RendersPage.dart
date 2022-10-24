import 'package:flutter/material.dart';

import '../../../../System/ProfileConstant.dart';

class RendersPage extends StatefulWidget {
  const RendersPage({Key? key}) : super(key: key);

  @override
  State<RendersPage> createState() => _RendersPageState();
}

class _RendersPageState extends State<RendersPage> {
  //late UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;
  bool movementX = false;
  bool movementY = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Card(
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: <Widget>[
              /*
              UnityWidget(
                onUnityCreated: onUnityCreated,
                onUnityMessage: onUnityMessage,
                fullscreen: false,
              ),*/
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconModify(
                      icono: Icon(Icons.arrow_left),
                      onTap: () {
                        //PreviusModule();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Modulo de 3 metros",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                          )),
                    ),
                    iconModify(
                      icono: Icon(Icons.arrow_right),
                      onTap: () {
                        //NextModule();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 95,
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
                              color: movementX ? Colors.green : Colors.black,
                            ),
                            onTap: () {
                              /*
                              setState(() {
                                movementX = movementX ? false : true;
                              });
                              setMovementX(movementX.toString());*/
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          iconModify(
                            icono: Icon(
                              Icons.currency_yuan,
                              color: movementY ? Colors.green : Colors.black,
                            ),
                            onTap: () {
                              /*
                              setState(() {
                                movementY = movementY ? false : true;
                              });
                              setMovementY(movementY.toString());*/
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                left: 20,
                right: 20,
                child: Card(
                  elevation: 2,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                            "Velocidad de Rotación: ${(_sliderValue * 1000).toStringAsFixed(0)}"),
                      ),
                      Slider(
                        onChanged: (value) {
                          /*
                          setState(() {
                            _sliderValue = value;
                          });
                          setRotationSpeed(value.toStringAsFixed(3));*/
                        },
                        value: _sliderValue,
                        min: 0.000,
                        max: 0.010,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
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
  }*/
}
