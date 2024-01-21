import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/themes.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/usurioperfil.dart';

AppBar buildAppBar(BuildContext context) {
  final modoOscuro = Theme.of(context).brightness == Brightness.dark;
   final icon = CupertinoIcons.moon_stars;
   final user = usuarioperfil.miUsuario;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            //user.modoOscuro ? MyThemes.darkTheme : MyThemes.lightTheme;
            final theme = modoOscuro ? MyThemes.lightTheme : MyThemes.darkTheme;

            final switcher = ThemeSwitcher.of(context)!;
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );

}
