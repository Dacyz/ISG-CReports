import 'package:flutter/material.dart';

import '../../../model/proyecto_Model.dart';
import '../../System/ProfileConstant.dart';
import 'newreport.dart';

class proyectodetalle extends StatefulWidget {
  final ProyectoModel proyectoModel;

  proyectodetalle(this.proyectoModel);

  @override
  State<proyectodetalle> createState() => _proyectodetalleState();
}

class _proyectodetalleState extends State<proyectodetalle> {
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 15);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/images/logooficial2.png",
            height: 30,
            width: 40,
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.proyectoModel.codProyecto}",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.brightness_medium_outlined,
              color: Color(0xFFF27900),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            //Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Primer boton
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => newreport())),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1E88E5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12),
                      side: const BorderSide(color: Color(0xFF084460)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      shadowColor: Colors.lightBlue,
                    ),
                    child: const Text("Nuevo Reporte",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  ),
                ),
                //Segundo reporte
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12),
                      side: const BorderSide(color: Color(0xFF084460)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      shadowColor: Colors.lightBlue,
                    ),
                    child: const Text("Historial de Reportes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            //Card con Imagen
            Container(
              padding: const EdgeInsets.all(12),
              width: 360,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xFFFFFFFF),
              ),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset("assets/images/imagencasa.jpg")),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Dirección: " + "${widget.proyectoModel.address}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            //Card Detalle
            SizedBox(
              width: 350,
              height: 330,
              child: Card(
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                            child: Text(
                          "DETALLE DEL PROYECTO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                        const SizedBox(height: 17),
                        Text(
                            "Beneficiario:  " +
                                "${widget.proyectoModel.beneficiario}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("DNI:  " + "${widget.proyectoModel.dni}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Teléfono:  " + "${widget.proyectoModel.telefono}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text(
                            "Contrato:  " +
                                "${widget.proyectoModel.codProyecto}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Modulo:  " + "${widget.proyectoModel.modulo}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text(
                            "Coordenadas:  " +
                                "${widget.proyectoModel.coordenadas}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text(
                            "Departamento:  " +
                                "${widget.proyectoModel.departamento}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text(
                            "Provincia:  " +
                                "${widget.proyectoModel.provincia}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Distrito:  " + "${widget.proyectoModel.distrito}",
                            style: textStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
