import 'package:flutter/material.dart';

import '../../../../model/ModeloCardProyecto.dart';
import '../../../System/ProfileConstant.dart';



class DetalleProyecto extends StatelessWidget {
  const DetalleProyecto({Key? key, required this.proyecto_model})
      : super(key: key);

  final ModeloCardProyecto proyecto_model;

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
            proyecto_model.url_imagen,
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          proyecto_model.cod_proyecto,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        proyecto_model.modulo,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
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
