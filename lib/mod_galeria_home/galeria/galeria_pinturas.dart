import 'package:flutter/material.dart';
import 'package:mod_comentario_scarlet/mod_galeria_home/galeria/descripcion_pintura.dart';
import 'package:xml/xml.dart' as xml;
import '../pintura.dart';

class galeria_pinturas extends StatefulWidget {
  const galeria_pinturas({Key? key}) : super(key: key);

  @override
  State<galeria_pinturas> createState() => _galeria_pinturasState();
}

class _galeria_pinturasState extends State<galeria_pinturas> {
  List<pinturas> paint = [];

  void initState() {
    super.initState();
    _leerPinturas();
  }

  Future<void> _leerPinturas() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString("documentos/pinturas.xml");
    final document = xml.XmlDocument.parse(data);
    final elementos = document.findAllElements("pinturas");

    setState(() {
      paint = elementos.map((elemento) {
        final nombre = elemento.findElements("nombre").first.text;
        final anio = elemento.findElements("anio").single.text;
        final Pintor = elemento.findElements("Pintor").single.text;
        final lugar_nacimiento =
            elemento.findElements("lugar_nacimiento").single.text;
        final descripcion_pintor =
            elemento.findElements("descripcion_pintor").single.text;
        final descripcion_pintura =
            elemento.findElements("descripcion_pintura").single.text;
        final image = elemento.findElements("image").single.text;

        return pinturas(
          nombre: nombre,
          anio: anio,
          Pintor: Pintor,
          lugar_nacimiento: lugar_nacimiento,
          descripcion_pintor: descripcion_pintor,
          descripcion_pintura: descripcion_pintura,
          image: image,
        );
      }).toList();
    });
  }

  void _mostrarDescripcion(BuildContext context, pinturas pintura) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => descripcion_pinturas(pintura: pintura),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 800,
        child: ListView.builder(
          itemCount: paint.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _mostrarDescripcion(context, paint[index]),
              child: Container(
                width: double.infinity,
                height: 220,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color.fromARGB(255, 255, 253, 230),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 130,
                          child: Image.network(
                            paint[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          paint[index].nombre,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
