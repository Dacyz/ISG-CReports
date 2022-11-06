import 'package:flutter/material.dart';
import 'package:insergemobileapplication/view/Pages/ReportPages/reportedetalle.dart';

import '../../../controller/remote_data_source/reportes_helper.dart';
import '../../../model/proyecto_Model.dart';
import '../../../model/reportes_Model.dart';
import '../../System/ProfileConstant.dart';

class listreportes extends StatefulWidget {
  ProyectoModel proyectoModel;
  listreportes(this.proyectoModel);

  @override
  State<listreportes> createState() => _listreportestState();
}

class _listreportestState extends State<listreportes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarTitle('Reportes'),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: StreamBuilder<List<ReportesModel>>(
            stream: Reportes_helper.read(widget.proyectoModel.id.toString()),
            builder: (context, snapshot) {
              print(widget.proyectoModel.dni.toString());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.toString()),
                );
              }
              if (snapshot.hasData) {
                final reportesData = snapshot.data;
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 3,
                      indent: 73,
                      endIndent: 15,
                      color: Color(0xFFFC4B08),
                      thickness: 1,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: reportesData!.length,
                  itemBuilder: (context, index) {
                    final singlereportes = reportesData[index];

                    return SizedBox(
                      child: Container(
                        child: ListTile(
                          leading: Icon(Icons.book_outlined,
                              color: Color(0xFFFC4B08)),
                          title: Text(
                            "${singlereportes.fecharegistro?.month}/${singlereportes.fecharegistro?.year}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(singlereportes.estado.toString()),
                          trailing: Icon(Icons.arrow_forward_rounded,
                              color: Color(0xFFFC4B08)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        reportedetalle(singlereportes)));
                          },
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
