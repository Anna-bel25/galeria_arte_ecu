import 'package:flutter/material.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/Botones.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/numeroRanking.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/profile_widget.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/themes.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/user.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/usurioperfil.dart';
//import 'package:mod_comentario_scarlet/mod_perfil_usuario/profile_widget.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/botonOscuro.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/EditarCuenta.dart';


class perfilView extends StatefulWidget {
  const perfilView({super.key});

  @override
  State<perfilView> createState() => _perfilViewViewState();
}

class _perfilViewViewState extends State<perfilView> {


  @override
  Widget build(BuildContext context) {
    final user = usuarioperfil.miUsuario;
    
    return Scaffold(
      
      appBar: buildAppBar(context),
    body: ListView(
    
     physics: BouncingScrollPhysics(),
     children: [
      ProfileWidget(
        imagen: user.imagen, 
        onClicked: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditProfilePage()),
          );
        },
        ),
     const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          numeroRanking(),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      )
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.nombre,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => Botones(
        text: 'Editar Cuenta',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sobre me',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.SobreMe,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
      
}