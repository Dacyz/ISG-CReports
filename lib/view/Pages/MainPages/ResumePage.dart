import 'package:flutter/material.dart';
import 'package:insergemobileapplication/controller/remote_data_source/home_helper.dart';
import 'package:insergemobileapplication/model/proyecto_Model.dart';
import 'package:insergemobileapplication/view/Pages/ProyectPages/DetailProyectPage.dart';

import '../../System/CardConstant.dart';
import '../../System/ProfileConstant.dart';

import '../Visualizator/VisualizatorPage.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  ProyectoModel LastProyect = ProyectoModel(address: 'Sin');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChargeData();
  }

  void ChargeData() {
    var miau = LastObject_helper.getLastProyect();
    miau.then((value) => value.elementAt(0).then((value) {
          LastProyect = value.elementAt(0);
          setState(() {});
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Bienvenido, Diego',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RotatedBox(
                quarterTurns: 135,
                child: Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.indigo,
                  size: 28,
                ),
              )
            ],
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: const [
              Text(
                'Resumen laboral',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              FutureBuilder(
                future: LastObject_helper.getCountProyects(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    snapshot.data?.elementAt(0).then((value) {
                      LastProyect == value.elementAt(0);
                    });
                    return CardMenu(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    proyectodetalle(LastProyect)));
                      },
                      title: 'Ultimo Proyecto registrado',
                      desc: LastProyect.address!,
                      icono: const Icon(
                        Icons.business,
                        color: secondColor,
                        size: 36,
                      ),
                    );
                  } else {
                    return CardMenu(
                      onTap: () {},
                      title: 'Ultimo Proyecto registrado',
                      desc: '...',
                      icono: const Icon(
                        Icons.business,
                        color: secondColor,
                        size: 36,
                      ),
                    );
                  }
                },
              ),
              FutureBuilder(
                future: LastObject_helper.countDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    snapshot.data;
                    return CardMenu(
                      onTap: () {},
                      title: 'Número de Proyectos registrados',
                      desc: snapshot.data.toString(),
                      icono: const Icon(
                        Icons.open_in_browser,
                        color: secondColor,
                        size: 36,
                      ),
                    );
                  } else {
                    return CardMenu(
                      onTap: () {},
                      title: 'Número de Proyectos registrados',
                      desc: '...',
                      icono: const Icon(
                        Icons.open_in_browser,
                        color: secondColor,
                        size: 36,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: const [
              Text(
                'Herramientas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          largeButtonRound(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VisualizatorPage(),
                ),
              );
            },
            title: 'Modulos',
            desc: 'Modelados 3D',
          ),
        ],
      ),
    );
  }
}
