import 'package:flutter/material.dart';

import '../../../../controller/ListProyects.dart';
import '../../../../model/ModeloCardProyecto.dart';
import '../../../System/CardConstant.dart';
import '../../../System/ProfileConstant.dart';
import 'DetalleProyectosScreen.dart';

class ProyectSearchPage extends StatefulWidget {
  ProyectSearchPage({Key? key}) : super(key: key);

  @override
  State<ProyectSearchPage> createState() => _ProyectSearchPageState();
}

class _ProyectSearchPageState extends State<ProyectSearchPage> {
  final controlador = TextEditingController(text: 'Buscar');

  List<ModeloCardProyecto> lista = modeloCardProyectos;

  @override
  Widget build(BuildContext context) {
    void buscar(String query) {
      final sugerencias = modeloCardProyectos.where((listaM) {
        final modulo = listaM.modulo.toLowerCase();
        final input = query.toLowerCase();
        return modulo.contains(input);
      }).toList();
      setState(() => lista = sugerencias);
    }

    List<String> listaModulos = [
      "3M",
      "3.5M",
      "4M",
      "6M",
      "7M",
    ];
    return Scaffold(
      body: SafeArea(
        //SingleChildScrollView
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Proyectos",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const Text(
                "Repositorio de Proyectos Inserge",
                style: TextStyle(fontSize: 18),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Ver todo",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const Expanded(child: barra_busqueda()),
              /*
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    listaModulos.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: defaultPadding),
                      child: ModeloCategoriaModulos(
                        titulo: listaModulos[index],
                        presionar: () {},
                      ),
                    ),
                  ),
                ),
              ),*/
              const SizedBox(height: defaultPadding),
              /*
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      final listaM = lista[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: 100,
                                  child: Image.asset(
                                    listaM.url_imagen,
                                  ),
                                ),
                              ),
                              title: Text(listaM.modulo),
                              subtitle: Text(listaM.cod_proyecto),
                              onTap: () {
                                /*
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => DetalleProyecto(
                                        Lista: listaM,
                                      )),
                                ),
                              ), */
                              }),
                        ),
                      );
                    },
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class barra_busqueda extends StatefulWidget {
  const barra_busqueda({super.key});

  @override
  State<barra_busqueda> createState() => _barra_busquedaState();
}

enum ViewType { grid, list }

class _barra_busquedaState extends State<barra_busqueda> {
  List<ModeloCardProyecto> lista = modeloCardProyectos;
  int _crossAxisCount = 2;
  double _aspectRatio = 1.5;
  ViewType _viewType = ViewType.grid;

  final TextEditingController _searchQuery = TextEditingController();

  @override
  void dipose() {
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: TextField(
            onChanged: buscar,
            controller: _searchQuery,
            decoration: InputDecoration(
                hintText: "Buscar Proyectos...",
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.search),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(defaultBorderRadius))),
                      ),
                      child: const Icon(Icons.candlestick_chart_outlined),
                    ),
                  ),
                )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Proyectos',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(
              child: IconButton(
                icon: Icon(_viewType == ViewType.list
                    ? Icons.grid_on
                    : Icons.view_list),
                onPressed: () {
                  if (_viewType == ViewType.list) {
                    _crossAxisCount = 2;
                    _aspectRatio = 1.5;
                    _viewType = ViewType.grid;
                  } else {
                    _crossAxisCount = 1;
                    _aspectRatio = 5;
                    _viewType = ViewType.list;
                  }
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: (_viewType == ViewType.list)
              ? Container(
                  child: (_searchQuery.text.isNotEmpty && lista.isEmpty)
                      ? Image.asset('assets/imagenes/not_found1.png')
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: lista.length,
                          itemBuilder: (context, index) {
                            final listaM = lista[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      height: 100,
                                      child: Image.asset(
                                        listaM.url_imagen,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    listaM.modulo,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  subtitle: Text(listaM.cod_proyecto),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              DetalleProyecto(
                                                Lista: listaM,
                                              )))),
                                ),
                              ),
                            );
                          },
                        ),
                )
              : Container(
                  child: (_searchQuery.text.isNotEmpty && lista.isEmpty)
                      ? Image.asset('assets/imagenes/not_found1.png')
                      : GridView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: lista.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            mainAxisExtent: 180,
                          ),
                          itemBuilder: (context, index) {
                            final listaM = lista[index];
                            return InkResponse(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => DetalleProyecto(
                                            Lista: listaM,
                                          )))),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.white,
                                boxShadow: defaultBoxShadow),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0)),
                                      child: Image.asset(
                                        listaM.url_imagen,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            listaM.modulo,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .merge(const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            listaM.cod_proyecto,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .merge(const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }

  void buscar(String query) {
    final sugerencias = modeloCardProyectos.where((element) {
      final modulo = element.modulo.toLowerCase();
      final direccion = element.cod_proyecto.toLowerCase();
      final input = query.toLowerCase();
      return modulo.contains(input) || direccion.contains(input);
    }).toList();
    setState(() => lista = sugerencias);
  }
}

class cardsP extends StatefulWidget {
  const cardsP({super.key});

  @override
  State<cardsP> createState() => _cardsP();
}

class _cardsP extends State<cardsP> {
  int _crossAxisCount = 2;
  double _aspectRatio = 1.5;
  ViewType _viewType = ViewType.grid;
  List<ModeloCardProyecto> lista = modeloCardProyectos;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Proyectos',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(
              child: IconButton(
                icon: Icon(_viewType == ViewType.list
                    ? Icons.grid_on
                    : Icons.view_list),
                onPressed: () {
                  if (_viewType == ViewType.list) {
                    _crossAxisCount = 2;
                    _aspectRatio = 1.5;
                    _viewType = ViewType.grid;
                  } else {
                    _crossAxisCount = 1;
                    _aspectRatio = 5;
                    _viewType = ViewType.list;
                  }
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: _crossAxisCount,
            childAspectRatio: _aspectRatio,
            children: modeloCardProyectos.map((ModeloCardProyecto modeloCP) {
              return getGridItem(modeloCP);
            }).toList(),
          ),
        ),
      ],
    );
  }

  GridTile getGridItem(ModeloCardProyecto modeloCP) {
    return GridTile(
      child: (_viewType == ViewType.list)
          ? Container(
              margin: const EdgeInsets.all(5),
              child: Row(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      modeloCP.url_imagen,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modeloCP.modulo,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      modeloCP.cod_proyecto,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                )
              ]),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        modeloCP.url_imagen,
                      )),
                ),
                Text(
                  modeloCP.modulo,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
    );
  }
}
