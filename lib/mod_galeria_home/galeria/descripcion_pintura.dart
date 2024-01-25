import 'package:flutter/material.dart';
import '../pintura.dart';

class descripcion_pinturas extends StatefulWidget {
  const descripcion_pinturas({Key? key, required this.pintura});

  final pinturas pintura;

  @override
  State<descripcion_pinturas> createState() => _DescripcionPinturasState();
}

class _DescripcionPinturasState extends State<descripcion_pinturas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(192, 240, 182, 161),
        title: const Text(
          "Pintura",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.brown),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 255, 251, 212),
              height: 180,
              child: Image.network(
                widget.pintura.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Año:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: AutofillHints.birthdayYear,
                  color: Colors.brown,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.pintura.anio,
                style: const TextStyle(
                  fontSize: 12.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pintor:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.brown,
                  fontFamily: AutofillHints.countryName,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.pintura.Pintor,
                style: const TextStyle(
                  fontSize: 12.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lugar de nacimiento del pintor:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.brown,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.pintura.lugar_nacimiento,
                style: const TextStyle(
                  fontSize: 12.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Descripción de la pintura:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.brown,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.pintura.descripcion_pintura,
                style: const TextStyle(
                  fontSize: 12.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Descripción del pintor:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.brown,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.pintura.descripcion_pintor,
                style: const TextStyle(
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
