import 'package:flutter/material.dart';

import '../../../controller/remote_data_source/proyectos_helper.dart';
import '../../../model/proyecto_Model.dart';
import '../../System/ProfileConstant.dart';
import 'proyectodetalle.dart';

class listproyect extends StatefulWidget {
  @override
  State<listproyect> createState() => _listproyectState();
}

class _listproyectState extends State<listproyect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: StreamBuilder<List<ProyectoModel>>(
            stream: Proyecto_helper.read(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Ocurrio el siguiente error al listar: '${snapshot.error}'", style: const TextStyle(color: Colors.red),));
              }
              if (snapshot.hasData) {
                final proyectoData = snapshot.data;
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 3,
                      indent: 73,
                      endIndent: 15,
                      color: Color(0xFFFC4B08),
                      thickness: 1,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: proyectoData!.length,
                  itemBuilder: (context, index) {
                    final singleproyecto = proyectoData[index];
                    return SizedBox(
                      child: ListTile(
                        leading: const Icon(Icons.book_outlined,
                            color: Color(0xFFFC4B08)),
                        title: Text(
                          "${singleproyecto.address}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${singleproyecto.codProyecto}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${singleproyecto.beneficiario}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_rounded,
                            color: Color(0xFFFC4B08)),
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
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
