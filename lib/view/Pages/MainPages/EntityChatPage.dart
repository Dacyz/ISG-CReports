import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insergemobileapplication/controller/usermanagement.dart';
import 'package:restart_app/restart_app.dart';

import '../../System/CardConstant.dart';
import '../../System/ProfileConstant.dart';

class EntityChatPage extends StatefulWidget {
  final User user;
  const EntityChatPage({super.key, required this.user});

  @override
  State<EntityChatPage> createState() => _EntityChatPageState(usuario: user);
}

class _EntityChatPageState extends State<EntityChatPage> {
  final User usuario;
  String nombreString = "";
  _EntityChatPageState({required this.usuario});

  @override
  Widget build(BuildContext context) {
    nombreString = usuario.displayName.toString() == 'null'
        ? ''
        : usuario.displayName.toString();
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orangeAccent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultMiniPadding),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mi perfil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _MetodoEditName();
                  },
                  child: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: defaultBoxShadow(Theme.of(context).shadowColor),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _RowConstant('Email:', usuario.email.toString()),
                _RowConstant('Nombre:', nombreString),
                _RowConstant('Verificacion:', usuario.emailVerified.toString()),
                _RowConstant('Anonimo:', usuario.isAnonymous.toString()),
                _RowConstant('Telefono:', usuario.phoneNumber.toString()),
                _RowConstant('UID:', usuario.uid.toString()),
                _RowConstant('Rol:', UsuarioGlobal.role),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    shortButtonRound(
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
        ],
      ),
    );
  }

  _MetodoEditName() => showDialog(
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
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                ),
                onChanged: (String value) {
                  nombreString = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                usuario.updateDisplayName(nombreString);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Para ver los cambios reinicia sesión"),
                  action: SnackBarAction(
                    label: 'Reiniciar',
                    onPressed: () {
                      Restart.restartApp();
                    },
                  ),
                ));
                setState(() {});
                Navigator.of(context).pop();
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

  _RowConstant(String title, String? content) {
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
}
