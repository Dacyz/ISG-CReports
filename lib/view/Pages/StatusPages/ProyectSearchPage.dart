import 'package:flutter/material.dart';

import '../../../controller/ListProyects.dart';
import '../../System/CardConstant.dart';
import '../../System/ProfileConstant.dart';
import 'DetalleProyectosScreen.dart';

class ProyectSearchPage extends StatelessWidget {
  const ProyectSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> listaModulos = [
      "3M",
      "3.5M",
      "4M",
      "6M",
      "7M",
    ];
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: Barra_de_Busqueda(),
            ),
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
            ),
            const SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Proyectos",
                  style: TextStyle(fontSize: 18),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Ver todo",
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              ],
            ),
            GridView.count(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: defaultPadding,
              primary: false,
              crossAxisSpacing: defaultPadding,
              children: List.generate(
                modeloCardProyectos.length,
                (index) => CardProyecto(
                  imagen: modeloCardProyectos[index].url_imagen,
                  titulo_proyecto: modeloCardProyectos[index].cod_proyecto,
                  estado: modeloCardProyectos[index].modulo,
                  presionar: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleProyecto(
                          proyecto_model: modeloCardProyectos[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Barra_de_Busqueda extends StatelessWidget {
  const Barra_de_Busqueda({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Buscar...",
            filled: true,
            fillColor: Colors.white,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.search),
            ),
            suffixIcon: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: SizedBox(
                height: 48,
                width: 48,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(defaultBorderRadius))),
                    ),
                    child: Center(
                        child: const Icon(
                      Icons.candlestick_chart_outlined,
                    )),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
