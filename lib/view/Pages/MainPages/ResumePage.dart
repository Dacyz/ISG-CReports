import 'package:flutter/material.dart';
import 'package:insergemobileapplication/controller/remote_data_source/resume_helper.dart';
import 'package:insergemobileapplication/model/proyecto_Model.dart';
import 'package:insergemobileapplication/view/Pages/ProyectPages/DetailProyectPage.dart';

import '../../System/ProfileConstant.dart';

import '../../System/Widgets/Buttons/LargeButtonRoundWidget.dart';
import '../../System/Widgets/Cards/MenuCardWidget.dart';
import '../Visualizator/VisualizatorPage.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  ProyectoModel lastProyect = ProyectoModel(address: '...');
  int proyectCount = 0;

  @override
  void initState() {
    super.initState();
    chargeData();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
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
                'Bienvenido a Inserge',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
              CardMenu(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailProyectPage(lastProyect)));
                },
                title: 'Último proyecto registrado',
                desc: lastProyect.address!,
                icono: const Icon(
                  Icons.business,
                  color: secondColor,
                  size: 36,
                ),
              ),
              CardMenu(
                onTap: () {},
                title: 'Número de proyectos registrados',
                desc: '$proyectCount',
                icono: const Icon(
                  Icons.open_in_browser,
                  color: secondColor,
                  size: 36,
                ),
              )
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
          LargeButtonRound(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VisualizatorPage(),
                ),
              );
            },
            title: 'Módulos',
            desc: 'Modelados 3D',
          ),
        ],
      ),
    );
  }

  void chargeData() async {
    lastProyect = await resume_helper.getLastProyec();
    proyectCount = await resume_helper.countDocuments();
    setState(() {});
  }
}
