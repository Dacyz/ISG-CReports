import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../model/ModeloImageGallery.dart';
import 'ProfileConstant.dart';

class CardProyecto extends StatelessWidget {
  const CardProyecto({
    Key? key,
    required this.imagen,
    required this.titulo_proyecto,
    required this.estado,
    required this.presionar,
  }) : super(key: key);

  final String imagen, titulo_proyecto, estado;
  final VoidCallback presionar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: presionar,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultBorderRadius)),
          boxShadow: defaultBoxShadow,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              child: Image.asset(imagen),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              titulo_proyecto,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              estado,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

Widget cardMenu({
  required String title,
  required String desc,
  required Icon icono,
  VoidCallback? onTap,
  Color fontColor = Colors.grey,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        boxShadow: defaultBoxShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icono,
          const SizedBox(height: 1),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
          ),
          const SizedBox(height: 1),
          Text(
            desc,
            style: TextStyle(fontWeight: FontWeight.normal, color: fontColor),
          )
        ],
      ),
    ),
  );
}

class ModeloCategoriaModulos extends StatelessWidget {
  const ModeloCategoriaModulos({
    Key? key,
    required this.titulo,
    required this.presionar,
  }) : super(key: key);

  final titulo;
  final VoidCallback presionar;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: presionar,
        style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(defaultBorderRadius)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 4, vertical: defaultPadding / 2),
          child: Column(
            children: [
              const Icon(Icons.house),
              const SizedBox(height: defaultPadding / 2),
              Text(
                titulo,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ));
  }
}

Widget cardImage({
  required String title,
  required int index,
  required String image,
  required List<ModeloCardGallery> list,
  required BuildContext context,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GalleryWidget(
            list: list,
            index: index,
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadius)),
        boxShadow: defaultBoxShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            child: Image.asset(image),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              title,
              overflow: TextOverflow.clip,
              softWrap: false,
            ),
          ),
          const SizedBox(
            height: 1,
          )
        ],
      ),
    ),
  );
}

class GalleryWidget extends StatefulWidget {
  final List<ModeloCardGallery> list;
  late int index;

  GalleryWidget({
    required this.list,
    this.index = 0,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          PhotoViewGallery.builder(
            pageController: PageController(initialPage: widget.index),
            itemCount: widget.list.length,
            builder: (context, index) {
              final urlImage = widget.list[index].src;
              return PhotoViewGalleryPageOptions(
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
                imageProvider: AssetImage(urlImage),
              );
            },
            onPageChanged: (index) {
              setState(() {
                widget.index = index;
              });
            },
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.list[widget.index].desc != '' &&
                          widget.list[widget.index].desc != null
                      ? '${widget.list[widget.index].desc}'
                      : '',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Tipo de Archivo: ${widget.list[widget.index].type}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Modulo: ${widget.list[widget.index].modulo}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}