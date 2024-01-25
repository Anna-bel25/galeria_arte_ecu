import 'dart:html';

import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:mod_comentario_scarlet/mod_galeria_home/homee/icon.dart';
import 'package:mod_comentario_scarlet/mod_galeria_home/pintura.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

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
        final lugar_nacimiento =elemento.findElements("lugar_nacimiento").single.text;
        final descripcion_pintor =elemento.findElements("descripcion_pintor").single.text;
        final descripcion_pintura =elemento.findElements("descripcion_pintura").single.text;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          child: PageView.builder(
            controller: pageController,
            itemCount: 1,
            itemBuilder: (context, position) {
              return _itemGaleria(position);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        //Seccion nuevo
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Nuevas",
                  style: TextStyle(
                      fontFamily: AutofillHints.name,
                      color: Color.fromARGB(255, 105, 76, 65),
                      fontSize: 18)),
              const SizedBox(
                width: 5,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: const Text(".",
                    style: TextStyle(
                        fontFamily: AutofillHints.name,
                        color: const Color.fromARGB(118, 0, 0, 0),
                        fontSize: 12)),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: const Text("Pinturas",
                    style: TextStyle(
                        fontFamily: AutofillHints.name,
                        color: const Color.fromARGB(118, 0, 0, 0),
                        fontSize: 11)),
              ),
            ],
          ),
        ),

        // contenedor de pinturas
        Container(
          height: 1000,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: paint.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 190,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color.fromARGB(255, 255, 253, 230),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250,
                          height: 130, // Ancho fijo para la imagen
                          child: Image.network(
                            paint[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                paint[index].nombre,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Pintor: ${paint[index].Pintor} ",
                                style: const TextStyle(
                                    fontFamily: AutofillHints.countryName,
                                    fontSize: 13),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Año: ${paint[index].anio}",
                                style: const TextStyle(
                                    fontFamily: AutofillHints.countryName,
                                    fontSize: 13),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Iconos(
                                      icon: Icons.circle_sharp,
                                      text: " Cultural",
                                      color: Color.fromARGB(76, 0, 0, 0),
                                      iconColor:
                                          Color.fromARGB(139, 255, 193, 7)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

//parte de arriba del body del home
  Widget _itemGaleria(int index) {
    return Stack(
      children: [
        Container(
          height: 200,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 211, 211, 211),
                  blurRadius: 10.0,
                  offset: Offset(0, 5)),
              BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
              BoxShadow(color: Colors.white, offset: Offset(5, 0))
            ],
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://iguana.hypotheses.org/files/2015/09/tigua1.jpg")),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 140,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 254, 255, 202),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tigua",
                      style: TextStyle(
                          fontFamily: AutofillHints.name,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Pintor: Julio Toaquiza",
                      style: TextStyle(
                          color: Color.fromARGB(115, 3, 3, 3), fontSize: 12),
                    ),
                    const Text("Año: 1970",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromARGB(115, 3, 3, 3), fontSize: 12)),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 171, 210, 230),
                                    size: 15,
                                  )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("4.5",
                            style: TextStyle(
                                color: Color.fromARGB(76, 0, 0, 0),
                                fontSize: 11)),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("valoraciones",
                            style: TextStyle(
                                color: Color.fromARGB(76, 0, 0, 0),
                                fontSize: 11)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Iconos(
                            icon: Icons.circle_sharp,
                            text: " Cultural",
                            color: Color.fromARGB(76, 0, 0, 0),
                            iconColor: Color.fromARGB(139, 255, 193, 7)),
                        Iconos(
                            icon: Icons.location_on,
                            text: " Cotopaxi",
                            color: Color.fromARGB(76, 0, 0, 0),
                            iconColor: Color.fromARGB(255, 171, 210, 230)),
                        Iconos(
                            icon: Icons.nature,
                            text: " Paisaje",
                            color: Color.fromARGB(76, 0, 0, 0),
                            iconColor: Color.fromARGB(255, 171, 210, 230))
                      ],
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
