import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insergemobileapplication/controller/usermanagement.dart';

import '../../System/ProfileConstant.dart';
import '../../System/Widgets/ShortButtonRoundWidget.dart';

class EntityChatPage extends StatefulWidget {
  final User user;
  const EntityChatPage({super.key, required this.user});

  @override
  State<EntityChatPage> createState() => _EntityChatPageState(usuario: user);
}

class _EntityChatPageState extends State<EntityChatPage> {
  final User usuario;
  String nombreString = "";
  String descString = "";

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  _EntityChatPageState({required this.usuario});

  @override
  void initState() {
    nombreString = usuario.displayName.toString() == 'null'
        ? ''
        : usuario.displayName.toString();
    nombreController.text = nombreString;
    descString = UsuarioGlobal.descripcion.toString() == 'null'
        ? ''
        : UsuarioGlobal.descripcion.toString();
    descripcionController.text = descString;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Text(
            'Mi perfil',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                _metodoEditData();
              },
              icon: const Icon(Icons.edit),
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orangeAccent,
              ),
              padding: EdgeInsets.all(defaultMiniPadding),
              child: Center(
                child: usuario.photoURL.toString() != 'null'
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.network(
                          usuario.photoURL.toString(),
                        ),
                      )
                    : const Icon(
                        Icons.person_off,
                        size: 72,
                      ),
              ),
            ),
            IconButton(
              onPressed: () {
                _metodoEditPhoto();
              },
              icon: const Icon(Icons.camera_alt),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        _descriptionProfile(descString),
        const SizedBox(height: defaultPadding),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: defaultBoxShadow(Theme.of(context).shadowColor),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _rowConstant('Nombre:', nombreString),
                  _rowConstant('Area:', UsuarioGlobal.area),
                  _rowConstant('Cargo:', UsuarioGlobal.cargo),
                  _rowConstant('Rol:', UsuarioGlobal.role),
                  _rowConstant('Telefono:', usuario.phoneNumber.toString()),
                  _rowConstant('Email:', usuario.email.toString()),
                  _rowConstant(
                      'Verificacion:', usuario.emailVerified.toString()),
                  _rowConstant('Anonimo:', usuario.isAnonymous.toString()),
                  _rowConstant('UID:', usuario.uid.toString()),
                  _rowConstant('Num sesiones:', "${UsuarioGlobal.sesiones}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ShortButtonRound(
                        title: 'Cerrar sesión',
                        onTap: () {
                          UserManagement().signOut(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _metodoEditData() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Actualizar"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    hintText: 'Nombre',
                  )),
              TextField(
                  controller: descripcionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Descripcion',
                  )),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                nombreString = nombreController.text;
                descString = descripcionController.text;
                try {
                  await usuario.updateDisplayName(nombreString);
                  await UserManagement.updateUserDescription(
                      descripcionController.text);
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Cambios guardados correctamente")));
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Ocurrio un error al guardar")));
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Actualizar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cerrar"),
            )
          ],
        );
      });

  _rowConstant(String title, String? content) {
    if (content != null && content != '' && content != 'null') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                content,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  _descriptionProfile(String? content) {
    if (content != null && content != '' && content != 'null') {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  void _metodoEditPhoto() {}
}
