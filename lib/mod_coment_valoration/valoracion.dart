import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  late Future<List<Obra>> _listadoObras;
  int selectedIndex = 0;
  var hawkFabMenuController;
  String currentScreen = 'Valoracion';
  


  @override
  void initState() {
    super.initState();
    _listadoObras = _verObras();
  }

  Future<List<Obra>> _verObras() async {
  final response = await http.get(Uri.parse('https://anna-bel25.github.io/api_comentario/obras.json'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data
        .map((obrasData) => Obra(
              autor: obrasData['autor'],
              titulo: obrasData['titulo'] ?? '',
              fechaPublicacion: obrasData['fecha_publicacion'] ?? '',
              descripcion: obrasData['descripcion'] ?? '',
              imagen: obrasData['imagen'] ?? '',
              valoracion: obrasData['valoracion'] ?? '',
            ))
        .toList();
  } else {
    throw Exception('Error de conexión');
  }
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

      floatingActionButton: buildHawkFabMenu(),

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
    return FutureBuilder<List<Obra>>(
      future: _listadoObras,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final obras = snapshot.data!;
          return ListView.builder(
            itemCount: obras.length,
            itemBuilder: (context, index) {
              final obra = obras[index];
              return Padding(
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
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
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




}

