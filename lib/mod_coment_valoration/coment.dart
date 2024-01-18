//import 'dart:ffi';

class Poeta {
  final String title;
  final String author;
  final String linecount;

  Poeta({
    required this.title,
    required this.author,
    required this.linecount,
  });
}


class Comentarios {
  final String fecha;
  final String nombre;
  final String comentario;
  final double valoracion;
  final String imagen;

  //double mutablevaloracion;

  Comentarios({
    required this.fecha,
    required this.nombre,
    required this.comentario,
    required this.valoracion,
    required this.imagen,
  });
  //: mutablevaloracion = double.parse(valoracion);
}


class Obra {
  final String autor;
  final String titulo;
  final String fechaPublicacion;
  final String descripcion;
  final String imagen;
  final String valoracion;

  double mutableValoracion;

  Obra({
    required this.autor, 
    required this.titulo, 
    required this.fechaPublicacion,
    required this.descripcion,
    required this.imagen,
    required this.valoracion,
    })
    : mutableValoracion = double.parse(valoracion);
}