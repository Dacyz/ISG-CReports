import 'package:flutter/material.dart';

class ModeloCardProyecto {
  final String cod_proyecto, modulo, url_imagen;

  ModeloCardProyecto({
    required this.cod_proyecto,
    required this.modulo,
    required this.url_imagen,
  });
}

List<ModeloCardProyecto> modeloCardProyectos = [
  ModeloCardProyecto(
    cod_proyecto: "Piura",
    modulo: "3M",
    url_imagen: "assets/images/FachadaModulo6.jpeg",
  ),
  ModeloCardProyecto(
    cod_proyecto: "Veintiseis de Octubre",
    modulo: "7",
    url_imagen: "assets/images/FachadaModulo62.jpeg",
  ),
  ModeloCardProyecto(
    cod_proyecto: "Chulucanas",
    modulo: "3.5M",
    url_imagen: "assets/images/FachadaModulo63.jpg",
  ),
  ModeloCardProyecto(
    cod_proyecto: "Sullana",
    modulo: "4",
    url_imagen: "assets/images/FachadaModulo64.jpeg",
  ),
  ModeloCardProyecto(
    cod_proyecto: "Raul Mata",
    modulo: "6",
    url_imagen: "assets/images/FachadaModulo62.jpeg",
  ),
  ModeloCardProyecto(
    cod_proyecto: "Sanchez Cerro",
    modulo: "7",
    url_imagen: "assets/images/FachadaModulo6.jpeg",
  ),
];
