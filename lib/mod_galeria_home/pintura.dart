import 'package:http/http.dart';

class pinturas {
  final String nombre;
  final String anio;
  final String Pintor;
  final String lugar_nacimiento;
  final String descripcion_pintor;
  final String descripcion_pintura;
  final String image;

  pinturas({
    required this.nombre,
    required this.anio,
    required this.Pintor,
    required this.lugar_nacimiento,
    required this.descripcion_pintor,
    required this.descripcion_pintura,
    required this.image,
  });
}
