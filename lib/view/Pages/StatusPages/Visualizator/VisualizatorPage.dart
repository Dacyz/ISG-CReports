import 'package:flutter/material.dart';

import '../../../../controller/ListGalery.dart';
import '../../../../model/ModeloImageGallery.dart';
import '../../../System/CardConstant.dart';
import '../../../System/ProfileConstant.dart';
import 'MinimalPages/RendersPage.dart';

class VisualizatorPage extends StatefulWidget {
  const VisualizatorPage({super.key});

  @override
  State<VisualizatorPage> createState() => _VisualizatorPageState();
}

class _VisualizatorPageState extends State<VisualizatorPage> {
  int _CurrentSelection = 0;
  int _CurrentSelection2 = 0;

  String module = '';
  String type = '';

  List<ModeloCardGallery> _listGallery = List.of(modeloCardGallery);

  Widget customRadioButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == _CurrentSelection) {
            _CurrentSelection = 0;
          } else {
            _CurrentSelection = index;
            module = title;
          }

          ModifyList();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: defaultBoxDecoration,
        child: Text(
          title,
          style: TextStyle(
              color: (_CurrentSelection == index)
                  ? Colors.blueAccent
                  : Colors.black,
              fontWeight: (_CurrentSelection == index)
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      ),
    );
  }

  Widget customRadioButton2(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == _CurrentSelection2) {
            _CurrentSelection2 = 0;
          } else {
            _CurrentSelection2 = index;
            type = title;
          }
          ModifyList();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: defaultBoxDecoration,
        child: Text(
          title,
          style: TextStyle(
              color: (_CurrentSelection2 == index)
                  ? Colors.blueAccent
                  : Colors.black,
              fontWeight: (_CurrentSelection2 == index)
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          foregroundColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          title: const Text(
            'Visualizador',
            style: TextStyle(color: Colors.blueAccent),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.blueAccent,
            indicatorWeight: 5,
            labelColor: Colors.blueAccent,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Galeria'),
              Tab(text: 'Render'),
            ],
          ),
        ),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customRadioButton("3M", 1),
                      customRadioButton("3.5M", 2),
                      customRadioButton("4M", 3),
                      customRadioButton("5M", 4),
                      customRadioButton("6M", 5),
                      customRadioButton("7M", 6),
                    ],
                  ),
                  const SizedBox(height: defaultShortPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customRadioButton2("Fotografias", 1),
                      customRadioButton2("Renders", 2),
                      customRadioButton2("Planos", 3),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  GridView.count(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: defaultPadding,
                    primary: false,
                    crossAxisSpacing: defaultPadding,
                    children: List.generate(
                      _listGallery.length,
                      growable: true,
                      (index) {
                        return cardImage(
                            index: index,
                            image: _listGallery[index].src,
                            title: _listGallery[index].desc != '' &&
                                    _listGallery[index].desc != null
                                ? '${_listGallery[index].desc}'
                                : '${_listGallery[index].type} de ${_listGallery[index].modulo}',
                            context: context,
                            list: _listGallery);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          RendersPage(),
        ]),
      ),
    );
  }

  void ModifyList() {
    _listGallery = List.empty(growable: true);
    if (_CurrentSelection == 0 && _CurrentSelection2 == 0) {
      for (var element in modeloCardGallery) {
        _listGallery.add(element);
      }
    } else {
      if (_CurrentSelection != 0 && _CurrentSelection2 == 0) {
        for (var element in modeloCardGallery) {
          if (module == element.modulo) {
            _listGallery.add(element);
          }
        }
      } else if (_CurrentSelection == 0 && _CurrentSelection2 != 0) {
        for (var element in modeloCardGallery) {
          if (type == element.type) {
            _listGallery.add(element);
          }
        }
      } else if (_CurrentSelection != 0 && _CurrentSelection2 != 0) {
        for (var element in modeloCardGallery) {
          if (module == element.modulo && type == element.type) {
            _listGallery.add(element);
          }
        }
      }
    }
  }
}
