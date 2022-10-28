import 'package:flutter/material.dart';

import '../../../model/proyecto_Model.dart';
import '../../System/ProfileConstant.dart';
import 'newreport.dart';

class proyectodetalle extends StatelessWidget {
  final ProyectoModel proyectoModel;

  const proyectodetalle(this.proyectoModel, {super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 15);
    return Scaffold(
      appBar: defaultAppBar,
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
                      child: Image.asset("assets/images/FachadaModulo6.jpeg")),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Dirección: " + "${proyectoModel.address}",
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
                            "Beneficiario:  " + "${proyectoModel.beneficiario}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("DNI:  " + "${proyectoModel.dni}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Teléfono:  " + "${proyectoModel.telefono}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Contrato:  " + "${proyectoModel.codProyecto}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Modulo:  " + "${proyectoModel.modulo}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Coordenadas:  " + "${proyectoModel.coordenadas}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text(
                            "Departamento:  " + "${proyectoModel.departamento}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Provincia:  " + "${proyectoModel.provincia}",
                            style: textStyle),
                        const SizedBox(height: 12),
                        Text("Distrito:  " + "${proyectoModel.distrito}",
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
