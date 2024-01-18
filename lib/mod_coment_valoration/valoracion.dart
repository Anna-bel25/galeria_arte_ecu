import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'coment.dart';
import 'dart:convert';
//import 'menu.dart';
import 'comentario.dart';
import 'foro.dart';

class Valoracion extends StatelessWidget {
  const Valoracion ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obras más Valoradas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 188, 191)),
        useMaterial3: true,
      ),
      home: const ValoracionPage(title: 'Obras más Valoradas'),
    );
  }
}

class ValoracionPage extends StatefulWidget {
  const ValoracionPage({super.key, required this.title});
  final String title;

  @override
  State<ValoracionPage> createState() => _ValoracionPageState();
}

class _ValoracionPageState extends State<ValoracionPage> {
  List<Obra> obras = [];
  int selectedIndex = 0;
  var hawkFabMenuController;
  String currentScreen = 'Valoracion';


  @override
  void initState() {
    super.initState();
    _verObras();
  }

  Future<void> _verObras() async {
    final jsonString = await DefaultAssetBundle.of(context).loadString('documento/obras.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    setState(() {
      obras = jsonData.map((obra) {
        return Obra(
          autor: obra['autor'],
          titulo: obra['titulo'],
          fechaPublicacion: obra['fecha_publicacion'],
          descripcion: obra['descripcion'],
          imagen: obra['imagen'],
          valoracion: obra['valoracion'],
        );
      }).toList();
    });
  }

  
  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //backgroundColor: Colors.transparent,
      //title: Text(widget.title),
      //elevation: 0,
      toolbarHeight: 100,
      flexibleSpace: _cabecera(),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //_cabecera(),
          Expanded(
            child: _obrasValoradas(),
          ),
        ],
      ),
      
      /*body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cabecera(),
                _obrasValoradas(),
                /*Expanded(
                  child: _obrasValoradas(),
                ),*/
              ],
            ),
          ),
        ),
      ),*/

      floatingActionButton: buildHawkFabMenu(),

      /*bottomNavigationBar: CustomMenu(
      items: ['Valoración', 'Foro', 'Comentario'],
      selectedIndex: selectedIndex,
      onItemSelected: (index) {
        setState(() {
          selectedIndex = index;
        });

        // Navegar a la pantalla correspondiente
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ValoracionPage(title: 'Valoracion')),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForoPage(title: 'Foro')),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ComentarioPage(title: 'Comentario')),
          );
        }
      },
    ),*/

  ); 
}


  Widget buildHawkFabMenu() {
    return HawkFabMenu(
      icon: AnimatedIcons.menu_arrow,
      fabColor: const Color.fromARGB(255, 255, 200, 0),
      iconColor: const Color.fromARGB(255, 72, 3, 22),
      hawkFabMenuController: hawkFabMenuController,
      items: [

        HawkFabMenuItem(
          label: 'Foro',
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Foro()),
            );
          },
          icon: const Icon(Icons.forum_outlined, color:Color.fromARGB(255, 238, 96, 163)),
          color: Colors.white,
          labelColor: Colors.white,
          labelBackgroundColor: const Color.fromARGB(255, 238, 96, 163),
        ),

        HawkFabMenuItem(
          label: 'Comentario',
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Comentario()),
            );
          },
          icon: const Icon(Icons.comment_outlined, color:Color.fromARGB(255, 238, 96, 163)),
          color: Colors.white,
          labelColor: Colors.white,
          labelBackgroundColor: const Color.fromARGB(255, 238, 96, 163),
        ),

        HawkFabMenuItem(
          label: 'Valoración',
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Valoracion()),
            );
          },
          color: currentScreen == 'Valoracion' ? Colors.white : const Color.fromARGB(255, 9, 149, 151),
          labelColor: currentScreen == 'Valoracion' ? Colors.white : const Color.fromARGB(255, 9, 149, 151),
          labelBackgroundColor: currentScreen == 'Valoracion' ? const Color.fromARGB(255, 9, 149, 151) : const Color.fromARGB(255, 238, 96, 163),

          icon: const Icon(Icons.star_border, color: Color.fromARGB(255, 9, 149, 151)),
        ),

      ],
      body: const SizedBox.shrink(),
    );
  }


  Widget _cabecera() {
    return Container (
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage('https://images.unsplash.com/photo-1579762593155-42faee39d0b4?q=80&w=1858&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            //BlendMode.dstATop,
            BlendMode.srcOver,
          ),
        ),
      ),
      
      child: const Center(
        child: Text('OBRAS MÁS VALORADAS',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        ),
      ),

    );
  }



  Widget _obrasValoradas() {
    return ListView.builder(
      itemCount: obras.length,
      itemBuilder: (context, index) {
        final obra = obras[index];
        return Padding(
          //padding: const EdgeInsets.all(20),
          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 8, top: 22),
          child: Card(
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    obra.imagen,
                    fit: BoxFit.contain, //cover
                  ),
                ),
                ListTile(
                  title: Text(
                    obra.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Autor: ${obra.autor}'),
                      Text('Fecha de Publicación: ${obra.fechaPublicacion}'),
                      Text('Descripción: ${obra.descripcion}'),
                      Row(
                        children: [
                          const Text('Valoración: '),
                          RatingBar.builder(
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              /*setState(() {
                                obra.mutableValoracion = rating;
                              });*/
                            },
                            itemCount: 5,
                            itemSize: 25,
                            allowHalfRating: true,
                            unratedColor: Colors.grey,
                            initialRating: obra.mutableValoracion,
                            updateOnDrag: true,
                            tapOnlyMode: false,
                            ignoreGestures: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }




}