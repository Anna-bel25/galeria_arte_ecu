import 'dart:convert';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class usuarioperfil {

  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  static User miUsuario = const User(
    imagen: 'https://th.bing.com/th/id/R.3c01a1055706f43a0900830bd4c411a0?rik=AyQpaOaa9fwq3Q&riu=http%3a%2f%2fwww.burblesoftware.com%2fimages%2fnews%2ftest-news-article-image-5.jpg&ehk=kSFk2xkVm3JNrj%2bjpcLT%2fCcmzBXyPMwdj6TWiRxm0Ag%3d&risl=&pid=ImgRaw&r=0',
    nombre:'María Zhingri',
    email:'mariazhingri@gmail.com',
    sobreMe: 'Estudiantes de noveno semestre de la carrera de ingeneria de software, me gusta los deporte extremos como parapente, cannoping, jumping, etc.',
    modoOscuro: false,
  );

    static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? miUsuario : User.fromJson(jsonDecode(json));
  }
}