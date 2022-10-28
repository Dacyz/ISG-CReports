import 'package:flutter/material.dart';

import '../../../../model/ModeloCardProyecto.dart';
import '../../../System/ProfileConstant.dart';

class DetalleProyecto extends StatefulWidget {
  final ModeloCardProyecto Lista;

  DetalleProyecto({super.key, required this.Lista});

  @override
  State<DetalleProyecto> createState() => _DetalleProyectoState(Lista: Lista);
}

class _DetalleProyectoState extends State<DetalleProyecto> {

  final ModeloCardProyecto Lista;
  _DetalleProyectoState({required this.Lista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            Lista.url_imagen,
            height: MediaQuery.of(context).size.height * 0.4, // Es 40%
            fit: BoxFit.cover,
          ),
          const SizedBox(height: defaultPadding / 8),
          Expanded(
              child: Container(
            padding: const EdgeInsets.fromLTRB(defaultPadding,
                defaultPadding * 2, defaultPadding, defaultPadding),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(defaultBorderRadius * 3),
                topRight: Radius.circular(defaultBorderRadius * 3),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RowConstant('Código:', "ISG-022-013"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Beneficiario:', "Diego Arturo Yangua Merino"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('DNI:', "75954109"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Dirección:', "Piura AV Chulucanas"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Módulo:', "7M"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Teléfono:', "992058519"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Coordenadas:', "xyz"),
                  const SizedBox(height: defaultPadding),
                  _RowConstant('Ubigeo:', "123456"),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

_RowConstant(String title, String content) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        content,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
