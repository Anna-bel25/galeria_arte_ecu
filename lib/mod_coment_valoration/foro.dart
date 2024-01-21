import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'valoracion.dart';
import 'comentario.dart';

class Foro extends StatelessWidget {
  const Foro({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(196, 109, 233, 215)),
        useMaterial3: true,
      ),
      home: const ForoPage(title: 'Foro'),
    );
  }
}

class ForoPage extends StatefulWidget {
  const ForoPage({Key? key, required this.title});
  final String title;

  @override
  State<ForoPage> createState() => _ForoPageState();
}

class _ForoPageState extends State<ForoPage> {
  late Future<List<Comentarios>> _listadoComentarios;
  
  int selectedIndex = 0;
  var hawkFabMenuController;
  String currentScreen = 'Foro';


  @override
  void initState() {
    super.initState();
    _listadoComentarios = _getForo();
  }


  Future<List<Comentarios>> _getForo() async {
  final response = await http.get(Uri.parse('https://anna-bel25.github.io/api_comentario/comentario.json'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<Comentarios> comentariosApi = data
        .map((comentariosaData) => Comentarios(
              fecha: comentariosaData['fecha'],
              nombre: comentariosaData['nombre'] ?? '',
              comentario: comentariosaData['comentario'] ?? '',
              valoracion: comentariosaData['valoracion'] ?? '',
              imagen: comentariosaData['imagen'] ?? '',
            ))
        .toList();

    // Obtener comentarios locales
    final prefs = await SharedPreferences.getInstance();
    final List<String> comentariosGuardados = prefs.getStringList('comentarios') ?? [];
    final List<LocalComentario> comentariosLocales = comentariosGuardados
        .map((comentarioJson) => LocalComentario.fromJson(jsonDecode(comentarioJson)))
        .toList();

    // Combinar comentarios de la API y comentarios locales
    final List<Comentarios> comentariosTotales = [...comentariosApi];
      for (final comentarioLocal in comentariosLocales) {

      comentariosTotales.add(
        Comentarios(
          fecha: comentarioLocal.fecha,
          nombre: comentarioLocal.nombre,
          comentario: comentarioLocal.comentario,
          valoracion: comentarioLocal.valoracion,
          imagen: comentarioLocal.imagen,
          //imagen: 'https://images.unsplash.com/photo-1579762593155-42faee39d0b4?q=80&w=1858&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ),
      );
  }
    return comentariosTotales;
  } else {
    throw Exception('Error de conexión');
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //title: Text(widget.title),
        toolbarHeight: 100,
        flexibleSpace: _cabecera(),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _foro(),
          ),
        ],
      ),
      
      floatingActionButton: buildHawkFabMenu(),

    );
  }



  Widget _cabecera() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(
              'https://images.unsplash.com/photo-1577720643360-00432b40139c?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            //BlendMode.dstATop,
            BlendMode.srcOver,
          ),
        ),
      ),
      child: const Center(
        child: Text(
          'FORO',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }


  Widget _foro() {
    return FutureBuilder<List<Comentarios>>(
      future: _listadoComentarios,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final comentarios = snapshot.data!;
          return ListView.builder(
            itemCount: comentarios.length,
            itemBuilder: (context, index) {
              final coment = comentarios[index];
              return Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 3, top: 6),
                //padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
                child: Card(
                  color: const Color.fromARGB(214, 211, 254, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    leading: ClipOval(
                      child: coment.imagen.isNotEmpty
                      ? Image.network(coment.imagen,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ): const SizedBox(),
                    ),

                    title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(coment.nombre,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(coment.fecha,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(coment.comentario,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(''),
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
                              initialRating: coment.valoracion,
                              updateOnDrag: true,
                              tapOnlyMode: false,
                              ignoreGestures: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
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
          color: currentScreen == 'Foro' ? Colors.white : const Color.fromARGB(255, 9, 149, 151),
          labelColor: currentScreen == 'Foro' ? Colors.white : const Color.fromARGB(255, 9, 149, 151),
          labelBackgroundColor: currentScreen == 'Foro' ? const Color.fromARGB(255, 9, 149, 151) : const Color.fromARGB(255, 238, 96, 163),

          icon: const Icon(Icons.forum_outlined, color: Color.fromARGB(255, 9, 149, 151)),
        ),

        HawkFabMenuItem(
          label: 'Comentario',
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Comentario()),
            );
          },
          icon: const Icon(Icons.comment_outlined, color: Color.fromARGB(255, 238, 96, 163)),
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
          icon: const Icon(Icons.star_border, color: Color.fromARGB(255, 238, 96, 163)),
          color: Colors.white,
          labelColor: Colors.white,
          labelBackgroundColor: const Color.fromARGB(255, 238, 96, 163),
        ),

      ],
      body: const SizedBox.shrink(),
    );
  }


}

