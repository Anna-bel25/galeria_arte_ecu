class User{
  final String imagen;
  final String nombre;
  final String email;
  final String sobreMe;
  final bool modoOscuro;


  const User({
    required this.imagen,
    required this.nombre,
    required this.email,
    required this.sobreMe,
    required this.modoOscuro,

  });

    User copy({
    String? imagen,
    String? nombre,
    String? email,
    String? sobreMe,
    bool? modoOscuro,
  }) =>
      User(
        imagen: imagen ?? this.imagen,
        nombre: nombre ?? this.nombre,
        email: email ?? this.email,
        sobreMe: sobreMe ?? this.sobreMe,
        modoOscuro: modoOscuro ?? this.modoOscuro,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagen: json['imagen'],
        nombre: json['nombre'],
        email: json['email'],
        sobreMe: json['SobreMe'],
        modoOscuro: json['modoOscuro'],
      );

  Map<String, dynamic> toJson() => {
        'imagen': imagen,
        'nombre': nombre,
        'email': email,
        'SobreMe': sobreMe,
        'modoOscuro': modoOscuro,
      };

}