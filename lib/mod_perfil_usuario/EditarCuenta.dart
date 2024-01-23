import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/Botones.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/profile_widget.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/user.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/usurioperfil.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/botonOscuro.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/TextFieldWidget .dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
  
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores actuales del usuario
    user = usuarioperfil.getUser();
  }

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
                  onClicked: () async {
                     final image = await ImagePicker()
                        .getImage(source: ImageSource.gallery);

                    if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    final name = basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage =
                        await File(image.path).copy(imageFile.path);

                    setState(() => user = user.copy(imagen: newImage.path));
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Nombre Completo',
                  text: user.nombre,
                  onChanged: (nombre) => user = user.copy(nombre: nombre),
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) => user = user.copy(email: email),
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Sobre Mi',
                  text: user.sobreMe,
                  maxLines: 5,
                  onChanged: (sobreMe) => user = user.copy(sobreMe: sobreMe),
                ),
                const SizedBox(height: 24),
                Botones(
                  text: 'Actualizar',
                  //backgroundColor: 
                  onClicked: () {
                    usuarioperfil.setUser(user);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
    );
}
}