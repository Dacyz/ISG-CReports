import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insergemobileapplication/view/System/ProfileConstant.dart';

import '../../../controller/remote_data_source/intelligence_helper.dart';
import '../../../model/proyecto_Model.dart';
import 'DetailProyectPage.dart';

class ResultProyectPage extends StatefulWidget {
  const ResultProyectPage({super.key, required this.query});
  final String query;

  @override
  State<ResultProyectPage> createState() => _ResultProyectPageState();
}

class _ResultProyectPageState extends State<ResultProyectPage> {
  String res = '';
  List<ProyectoModel>? proyectoData;
  Stream<List<ProyectoModel>> ListaDeProyects = Stream.empty();

  void Carga() {
    Search_helper.read(widget.query).then((value) {
      setState(() {
        ListaDeProyects = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Carga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarTitle('Resultado de busqueda'),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Termino buscado: ${widget.query}',
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Resultado de busqueda:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(res),
              StreamBuilder<List<ProyectoModel>>(
                  stream: ListaDeProyects,
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
                          child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
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
                            padding: EdgeInsets.symmetric(
                                vertical: defaultShortPadding),
                            decoration: defaultBoxDecoration(
                                Theme.of(context).cardColor,
                                Theme.of(context).shadowColor),
                            child: ListTile(
                              title: Text(
                                "[${singleproyecto.codProyecto}] ${singleproyecto.beneficiario}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Dirección: ${singleproyecto.address}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "DNI: ${singleproyecto.dni} | Telefono: ${singleproyecto.telefono}",
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
                      ));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ]),
      )),
    );
  }
}
