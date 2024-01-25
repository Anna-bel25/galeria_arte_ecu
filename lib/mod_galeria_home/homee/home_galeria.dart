import 'package:flutter/material.dart';
import 'package:mod_comentario_scarlet/mod_coment_valoration/valoracion.dart';
import 'package:mod_comentario_scarlet/mod_galeria_home/galeria/galeria_pinturas.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/perfil.dart';
import 'home_body.dart';

class homeGaleria extends StatefulWidget {
  const homeGaleria({Key? key}) : super(key: key);

  @override
  State<homeGaleria> createState() => _homeGaleriaState();
}

class _homeGaleriaState extends State<homeGaleria> {
  int pagina_actual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color:const Color.fromARGB(255, 240, 210, 199),
            margin: const EdgeInsets.only(bottom: 12),
            child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 35, bottom: 25),
              child: const Column(
                children: [
                  Text(
                    "Galeria de arte Ecuatoriano",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: pagina_actual,
              children: const [
                SingleChildScrollView(
                  child: HomeBody(),
                ),
                galeria_pinturas(),
                Valoracion(),
                perfilView(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pagina_actual = index;
          });
        },
        currentIndex: pagina_actual,
        selectedItemColor: const Color.fromARGB(255, 143, 141, 27), 
        unselectedItemColor: Colors.grey, 
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: "Galeria",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: "Valoracion",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
