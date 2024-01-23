import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/profile_widget.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/user.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/usurioperfil.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/botonOscuro.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/TextFieldWidget .dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = usuarioperfil.miUsuario;

@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
    body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagen: user.imagen,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Nombre Completo',
                  text: user.nombre,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Sobre Mi',
                  text: user.SobreMe,
                  maxLines: 5,
                  onChanged: (about) {},
                ),
              ],
            ),
    );
}
}