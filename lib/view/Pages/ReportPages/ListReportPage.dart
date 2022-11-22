import 'package:flutter/material.dart';

import '../../../controller/remote_data_source/reportes_helper.dart';
import '../../../model/proyecto_Model.dart';
import '../../../model/reportes_Model.dart';
import '../../System/ProfileConstant.dart';
import 'DetailReportPage.dart';

class ListReportPage extends StatefulWidget {
  final ProyectoModel proyectoModel;

  const ListReportPage(this.proyectoModel, {super.key});

  @override
  State<ListReportPage> createState() => _ListReportPageState();
}

class _ListReportPageState extends State<ListReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarTitle('Reportes'),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: StreamBuilder<List<ReportesModel>>(
            stream: Reportes_helper.read(widget.proyectoModel.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
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
                    return const Divider(
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
                          leading: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Color(0xFFFC4B08),
                            size: 35,
                          ),
                          title: Text(
                            "Fecha: " +
                                "${singlereportes.fecharegistro?.day}/${singlereportes.fecharegistro?.month}/${singlereportes.fecharegistro?.year}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text("Hora: " +
                              "${singlereportes.fecharegistro?.hour}:${singlereportes.fecharegistro?.minute}"),
                          trailing: const Icon(Icons.arrow_forward_rounded,
                              color: Color(0xFFFC4B08)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailReportPage(singlereportes)));
                          },
                        ),
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
