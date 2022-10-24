import 'package:flutter/material.dart';

import '../../System/CardConstant.dart';
import '../../System/ProfileConstant.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

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
                ' Martes, 27 de setiembre 2022',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          GestureDetector(
            onTap: () {
              /*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProyectSearchPage(),
                ),
              );*/
            },
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.search_outlined),
                  ),
                  Text(
                    "Buscar...",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: const [
              Text(
                'Resumen laboral',
                style: TextStyle(
                  color: Colors.black54,
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
              cardMenu(
                onTap: () {},
                title: 'Ult Proyecto',
                desc: 'Villa Esperanza',
                icono: const Icon(
                  Icons.business,
                  color: secondColor,
                  size: 36,
                ),
              ),
              cardMenu(
                onTap: () {},
                title: 'Operacion 2',
                desc: 'Desc Operacion',
                icono: const Icon(
                  Icons.open_in_browser,
                  color: secondColor,
                  size: 36,
                ),
              ),
              cardMenu(
                onTap: () {},
                title: 'Operacion 3',
                desc: 'Desc Operacion',
                icono: const Icon(
                  Icons.image,
                  color: secondColor,
                  size: 36,
                ),
              ),
              cardMenu(
                onTap: () {
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VisualizatorPage(),
                    ),
                  );*/
                },
                title: 'Proyectos Asig.',
                desc: '15',
                icono: const Icon(
                  Icons.brush_sharp,
                  color: secondColor,
                  size: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
