import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

import 'comentario.dart';
import 'foro.dart';
import 'valoracion.dart';

class CustomHawkFabMenu extends StatelessWidget {
  final String currentScreen;
  final HawkFabMenuController hawkFabMenuController;

  const CustomHawkFabMenu({
    Key? key,
    required this.currentScreen,
    required this.hawkFabMenuController, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HawkFabMenu(
      icon: AnimatedIcons.menu_arrow,
    fabColor: Color.fromARGB(255, 255, 213, 59),
    iconColor: const Color.fromARGB(255, 175, 76, 122),
    hawkFabMenuController: hawkFabMenuController,
    items: [

      HawkFabMenuItem(
        label: 'Foro',
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Foro()),
          );
        },
        icon: const Icon(Icons.forum_outlined),
        color: Colors.white,
        labelColor: Colors.white,
        labelBackgroundColor: const Color.fromARGB(255, 33, 100, 243),
      ),

      HawkFabMenuItem(
        label: 'Comentario',
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Comentario()),
          );
        },
        icon: const Icon(Icons.comment_outlined),
        color: Colors.white,
        labelColor: Colors.white,
        labelBackgroundColor: const Color.fromARGB(255, 33, 100, 243),
      ),

      HawkFabMenuItem(
        label: 'Valoración',
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Valoracion()),
          );
        },
        color: currentScreen == 'Valoracion' ? Colors.red : Colors.white,
        labelColor: currentScreen == 'Valoracion' ? Colors.red : Colors.white,
        labelBackgroundColor: currentScreen == 'Valoracion' ? Colors.white : Colors.blue,

        icon: const Icon(Icons.star_border, color: Colors.white),

        //icon: const Icon(Icons.star_border),
        //color: Colors.white,
        //labelColor: Colors.white,
        //labelBackgroundColor: const Color.fromARGB(255, 33, 100, 243),
      ),

    ],
    body: SizedBox.shrink(),
  );
  }
}
