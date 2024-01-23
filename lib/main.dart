import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_box/flutter_text_box.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

import 'package:mod_comentario_scarlet/mod_coment_valoration/comentario.dart';
import 'package:mod_comentario_scarlet/navmain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mod_comentario_scarlet/mod_perfil_usuario/themes.dart';
import 'package:mod_comentario_scarlet/mod_perfil_usuario/usurioperfil.dart';
//import 'package:mod_comentario_scarlet/navmain.dart';
//import 'package:shared_preferences/shared_preferences.dart';


import 'mod_coment_valoration/valoracion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = usuarioperfil.miUsuario;

    return ThemeProvider(
      initTheme: MyThemes.lightTheme,
      builder: (context, theme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const MyHomePage(title: 'Login'),
      );
    },
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  final key = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ButtonStyle style = FilledButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 16,
      //fontWeight: FontWeight.bold,
    ),
    //backgroundColor: Color.fromARGB(160, 222, 247, 249),
  );
  String email = "", password = "";
  bool? recordar_pw = false;

  String? storedEmail;
  String? storedPassword;


  @override
void initState() {
  super.initState();
}


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage("https://images.unsplash.com/photo-1602422701241-7ba4f6fc1712?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.dstATop,
              //BlendMode.srcOver,
            ),
          ),
        ),

        padding: const EdgeInsets.symmetric(horizontal: 34),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _login(),
            _botones(context),
          ]
        )
      ),
    );
  }


Widget _login() {
  return Center(
    child: Form(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          const Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),

          const SizedBox(height: 16),
          TextBoxIcon(
            icon: Icons.email_outlined,
            inputType: TextInputType.emailAddress,
            label: 'Correo',
            hint: 'Ingrese su correo electronico',
            errorText: 'Este campo es requerido !',
            onSaved: (String value) {
              email = value;
            },
          ),

          const SizedBox(height: 16),
          TextBoxIcon(
            icon: Icons.password_outlined,
            label: 'Contraseña',
            hint: 'Ingrese su contraseña',
            errorText: 'Este campo es requerido !',
            obscure: true,
            onSaved: (String value) {
              password = value;
            },
          ),

          const SizedBox(height: 14),
          CheckboxListTileFormField(
            title: const Text('Recordar contraseña'),
            onSaved: (bool? value) {
              recordar_pw = value;
              },
          ),
        const SizedBox(height: 35),

        ],
      ),
    ),
  );
}



Widget _botones(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 16),
        ElevatedButton(
          //style: style,
          onPressed: () => ingresar(context),
          child: const Text('Ingresar', textAlign: TextAlign.center),
        ),

        const SizedBox(height: 16),
        ElevatedButton(
          //style: style,
          //onPressed: () => salir(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Comentario()),
              );
          },
          child: const Text('Salir', textAlign: TextAlign.center),
        ),
      ],
    ),
  );
}

void salir() {
  print("Ha salido del sistema");
}

void ingresar(BuildContext context) {
  final state = key.currentState;
  if (state!.validate()) {
    state.save();
    print("Ha ingresado del sistema");
    print("Verificando");
    print(email);
    print(password);
    print(recordar_pw);

    if (storedEmail != null && storedPassword != null && _validarCredenciales(storedEmail!, storedPassword!)) {
      print("Acceso concedido con credenciales almacenadas");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } else {
      if (_validarCredenciales(email, password)) {
        print("Acceso concedido");
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
        if (recordar_pw == true) {
          saveCredentials();
        }
      } else {
        print("Error en las credenciales de acceso");
      }
    }
  }
    
}

  void saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  bool _validarCredenciales(String email, String password) {
    String userEmail = "grupo6";
    String userPassword = "123";
    return email == userEmail && password == userPassword;
  }

}
