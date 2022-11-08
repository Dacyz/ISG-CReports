import 'package:flutter/material.dart';
import 'package:insergemobileapplication/view/Pages/ProyectPages/DetailProyectPage.dart';

import '../../../controller/remote_data_source/proyectos_helper.dart';
import '../../../model/proyecto_Model.dart';
import '../../System/ProfileConstant.dart';

class listproyect extends StatefulWidget {
  @override
  State<listproyect> createState() => _listproyectState();
}

enum ViewType { grid, list }

class _listproyectState extends State<listproyect> {
  late List<ProyectoModel> lista;

  int _crossAxisCount = 2;
  double _aspectRatio = 1.5;
  ViewType _viewType = ViewType.grid;

  final TextEditingController _searchQuery = TextEditingController();
  List<ProyectoModel>? proyectoData;

  void buscar(String query) {
    final sugerencias = proyectoData?.where((listaM) {
      final modulo = listaM.address?.toLowerCase();
      final input = query.toLowerCase();
      return modulo!.contains(input);
    }).toList();
    print("sugerencias: $sugerencias.");
    setState(() => lista = sugerencias!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: defaultPadding,
                left: defaultPadding,
                right: defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Proyectos",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
                const SizedBox(height: defaultPadding),
                const Text(
                  "Repositorio de Proyectos Inserge",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: defaultPadding),
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
                              child:
                                  const Icon(Icons.candlestick_chart_outlined),
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
              ],
            ),
          ),
          StreamBuilder<List<ProyectoModel>>(
              stream: Proyecto_helper.read(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ocurrio el siguiente error al listar: '${snapshot.error}'",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ));
                }
                if (snapshot.hasData) {
                  proyectoData = snapshot.data;
                  // Acá cambiar
                  return Expanded(
                    child: (_viewType != ViewType.list)
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding,
                                vertical: defaultShortPadding),
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: defaultPadding,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: proyectoData!.length,
                            itemBuilder: (context, index) {
                              final singleproyecto = proyectoData![index];
                              return Container(
                                decoration: defaultBoxDecoration,
                                padding: EdgeInsets.all(4),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      height: 100,
                                      child: Image.asset(
                                        "${singleproyecto.image}",
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "${singleproyecto.address}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "[${singleproyecto.codProyecto}] ${singleproyecto.beneficiario}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            proyectodetalle(singleproyecto),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(defaultPadding),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: proyectoData!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              mainAxisExtent: 180,
                            ),
                            itemBuilder: (context, index) {
                              final listaM = proyectoData![index];
                              return InkResponse(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          proyectodetalle(listaM),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: defaultBoxDecoration,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16.0),
                                            topRight: Radius.circular(16.0)),
                                        child: Image.asset(
                                          "${listaM.image}",
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
                                              "${listaM.beneficiario}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .merge(
                                                    const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(
                                              "${listaM.codProyecto}",
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
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }
}
