class LocalComentario {
  final String fecha;
  final String nombre;
  final String comentario;
  final double valoracion;
  final String imagen;

  LocalComentario({
    required this.fecha,
    required this.nombre,
    required this.comentario,
    required this.valoracion,
    required this.imagen,
  });

  Map<String, dynamic> toJson() {
    return {
      'fecha': fecha,
      'nombre': nombre,
      'comentario': comentario,
      'valoracion': valoracion,
      'imagen': imagen,
    };
  }

  factory LocalComentario.fromJson(Map<String, dynamic> json) {
    return LocalComentario(
      fecha: json['fecha'],
      nombre: json['nombre'],
      comentario: json['comentario'],
      valoracion: json['valoracion'],
      imagen: json['imagen'],
    );
  }
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