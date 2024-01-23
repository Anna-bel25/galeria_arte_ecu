import 'package:flutter/material.dart';
import 'package:mod_comentario_scarlet/mod_coment_valoration/valoracion.dart';
import 'package:mod_comentario_scarlet/mod_galeria_home/ivette.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/perfil.dart';
//import 'package:mod_comentario_scarlet/mod_perfil_usuario/perfil.dart';
//import 'package:mod_comentario_scarlet/mod_perfil_usuario/EditarCuenta.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final screens = [const Valoracion(), const ivetteView(), const perfilView()];

    return Scaffold(
      
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            activeIcon: Icon(Icons.account_balance),
            label: 'Obras',
            backgroundColor:  Color.fromARGB(255, 18, 127, 116),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Galeria',
            backgroundColor: Color.fromARGB(255, 18, 127, 116),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            activeIcon: Icon(Icons.person_3),
            label: 'Cuenta',
            backgroundColor: Color.fromARGB(255, 18, 127, 116),
          ),
        ],
      ),
    );
  }
}