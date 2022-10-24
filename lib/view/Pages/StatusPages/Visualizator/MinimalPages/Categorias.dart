import 'package:flutter/material.dart';

class Categorias extends StatefulWidget {
  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  int _groupValue = -1;
  int _disable = 3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: 125,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            radiocategorias("Entrega de Materiales", 1),
            radiocategorias("Ubicación y limpieza de terreno", 2),
            radiocategorias("Trazo y excavación de zanjas para cimiento", 3),
            radiocategorias("Armado de columnas", 4),
            radiocategorias("Vaciado de cimientos", 5),
            radiocategorias("Armado y vaciado de sobrecimiento", 6),
            radiocategorias("Asentado de ladrillos", 7),
            radiocategorias("Vaciado de Columna", 8),
            radiocategorias("Acero de techo y encofrado", 9),
          ],
        ),
      ),
    );
  }

  //
  Widget radiocategorias(String title, int index) {
    return Container(
      width: 120,
      child: Card(
        color: index > _disable? Colors.white : Colors.white54,
        child: Column(
          children: [
            Radio(
              value: index,
              groupValue: _groupValue,
              onChanged: (newValue) {
                setState(() {
                  if (index > _disable) {
                    _groupValue = newValue!;
                  }
                });
              },
            ),
            Expanded(
                child: Text(
              title,
              textAlign: TextAlign.center,
            ))
          ],
        ),
      ),
    );
  }
}
