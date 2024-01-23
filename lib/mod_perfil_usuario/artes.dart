import 'package:flutter/material.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/Favoritos.dart';
import 'package:xml/xml.dart' as xml;

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<favoritos> arte = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _leerFavoritos();
  }

  Future<void> _leerFavoritos() async {
    try {
    final data =
        await DefaultAssetBundle.of(context).loadString("documentos/favoritos.xml");
    final document = xml.XmlDocument.parse(data);
    final elementos = document.findAllElements("arte");

    setState(() {
      arte = elementos.map((elemento) {
        final nombre = elemento.findElements("nombre").first.text;
        final descripcion = elemento.findElements("descripcion").single.text;
        final imagen = elemento.findElements("imagen").single.text;

        return favoritos(
          nombre: nombre,
          descripcion: descripcion,
          imagen: imagen,
        );
      }).toList();
    });
    } catch (e) {
  print("Error al cargar o analizar el archivo XML: $e");
}
  }



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Favoritos'),
      ),
      body: ListView.builder(
        itemCount: arte.length,
        itemBuilder: (context,index){
          return Container(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              child: ListTile(
                title: Text(arte[index].nombre,
                style:const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
        children: [
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Descripción: ',style: TextStyle(fontWeight: FontWeight.bold),),
                Text(arte[index].descripcion),
              ],
            ),
          ),
          SizedBox(width: 10),
          Image.network(
            arte[index].imagen,
            height: 200, 
            width: 200,
            fit: BoxFit.cover,
          ),
                ],
              ),
                
              )
            ),
          );
        }),
      
    );
  }
}