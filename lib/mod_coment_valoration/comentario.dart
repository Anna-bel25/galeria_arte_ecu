import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:intl/intl.dart';
//import 'menu.dart';
import 'valoracion.dart';
import 'foro.dart';

class Comentario extends StatelessWidget {
  const Comentario ({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Comentario',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 188, 191)),
          useMaterial3: true,
        ),
        home: const ComentarioPage(title: 'Comentario'),
      );
    }
  }

class ComentarioPage extends StatefulWidget {
  const ComentarioPage({super.key, required this.title});
  final String title;

  @override
  State<ComentarioPage> createState() => _ComentarioPageState();
}

class _ComentarioPageState extends State<ComentarioPage> {
  final key = GlobalKey<FormState>();
  final ButtonStyle style = FilledButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 16,
      //fontWeight: FontWeight.bold,
    ),
    //backgroundColor: Color.fromARGB(160, 222, 247, 249),
  );

  String nombre = "", comentario = "";
  DateTime? fecha;
  double valoracion = 0;
  
  int selectedIndex = 0;
  var hawkFabMenuController;
  String currentScreen = 'Comentario';

  

@override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //title: Text(widget.title),
      toolbarHeight: 100,
      flexibleSpace: _cabecera(),
    ),

     /*body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cabecera(),
          Expanded(
            child: Column(
              children: [
                _formulario(),
                _botones(),
              ],
            ),
          ),
        ],
      ),*/

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //_cabecera(),
                _formulario(),
                _botones(),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: buildHawkFabMenu(),

      /*bottomNavigationBar: CustomMenu(
        items: ['Comentario', 'Valoración', 'Foro'],
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });

          // Navegar a la pantalla correspondiente
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ValoracionPage(title: 'Valoracion',)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForoPage(title: 'Foro',)),
            );
          }
        },
      ),*/


      /*bottomNavigationBar: Menu(
      currentIndex: currentIndex,
      onTabChange: (index) {
        setState(() => currentIndex = index);
      },
      getContext: () => context,
      colors: [Colors.cyan, Colors.purple, Colors.green, Colors.red],
    ),*/

      
  );
}



  Widget buildHawkFabMenu() {
    return HawkFabMenu(
      icon: AnimatedIcons.menu_arrow,
      fabColor: const Color.fromARGB(255, 255, 200, 0),
      iconColor: const Color.fromARGB(255, 72, 3, 22),
      hawkFabMenuController: hawkFabMenuController,
      items: [

        HawkFabMenuItem(
          label: 'Foro',
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Foro()),
            );
          },
          icon: const Icon(Icons.forum_outlined, color: Color.fromARGB(255, 238, 96, 163)),
          color: Colors.white,
          labelColor: Colors.white,
          labelBackgroundColor: const Color.fromARGB(255, 238, 96, 163),
        ),

        HawkFabMenuItem(
          label: 'Comentario',
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Comentario()),
            );
          },
          color: currentScreen == 'Comentario' ? Colors.white : const Color.fromARGB(255, 9, 149, 151),
          labelColor: currentScreen == 'Comentario' ? Colors.white : const Color.fromARGB(255, 9, 149, 151),
          labelBackgroundColor: currentScreen == 'Comentario' ? const Color.fromARGB(255, 9, 149, 151) : const Color.fromARGB(255, 238, 96, 163),

          icon: const Icon(Icons.comment_outlined, color: Color.fromARGB(255, 9, 149, 151)),
        ),

        HawkFabMenuItem(
          label: 'Valoración',
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Valoracion()),
            );
          },
          icon: const Icon(Icons.star_border, color: Color.fromARGB(255, 238, 96, 163)),
          color: Colors.white,
          labelColor: Colors.white,
          labelBackgroundColor: const Color.fromARGB(255, 238, 96, 163),
        ),

      ],
      body: const SizedBox.shrink(),
    );
  }



  Widget _cabecera() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage('https://images.unsplash.com/photo-1549289524-06cf8837ace5?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cGludHVyYXN8ZW58MHx8MHx8fDA%3D',),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            //BlendMode.dstATop,
            BlendMode.srcOver,
          ),
        ),
        ),
        
        child: const Center(
          child: Text('COMENTANOS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),

        ),
      ),
    );
  }



  Widget _formulario() {
    return Column(
      children: [
        const SizedBox(height: 35),
        Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
          color: Color.fromARGB(67, 26, 188, 191),
          width: 0.8,
          ),
        ),
        
        child: ListTile(
          title: const Text("Seleccione la fecha",
          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 74, 75, 75)),
          ),
          
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null && pickedDate != fecha) {
              setState(() {
                fecha = pickedDate;
                });
              }
            },
            
            subtitle: fecha != null? Text( "${DateFormat('dd-MM-yyyy').format(fecha!)}",
              style: const TextStyle(fontSize: 16),) : null,
              trailing: Container(
                margin: const EdgeInsets.only(left: 24),
                child: const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Color.fromARGB(187, 8, 123, 217)
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Color.fromARGB(67, 26, 188, 191),
                width: 0.8,
              ),
            ),

            child: ListTile(
              title: const Text(
                "Ingresar nombre",
                style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 74, 75, 75)),
              ),

              trailing: Container(
                margin: const EdgeInsets.only(left: 24),
                child: const Icon(
                  Icons.supervised_user_circle_outlined,
                  size: 18,
                  color: Color.fromARGB(187, 8, 123, 217)
                ),
              ),

              subtitle: TextFormField( 
                //maxLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Escribe tu apodo aquí',
                ),

                onSaved: (String? value) {
                  if (value != null) {
                    nombre = value;
                  }

                },
              ),

            ),
          ),


        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Color.fromARGB(67, 26, 188, 191),
              width: 0.8,
            ),
          ),

          child: ListTile(
            title: const Text(
              "Añadir comentario",
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 74, 75, 75)),
            ),
            
          trailing: Container(
            margin: const EdgeInsets.only(left: 24),
            child: const Icon(
              Icons.text_snippet_outlined,
              size: 24,
              color: Color.fromARGB(187, 8, 123, 217)
            ),
          ),

            subtitle: TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Escribe tu comentario aquí',
              ),

              onSaved: (String? value) {
                if (value != null) {
                  comentario = value;
                }

              },
            ),
          ),
        ),


        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Color.fromARGB(67, 26, 188, 191),
              width: 0.8,
            ),
          ),
          child: ListTile(
            title: const Text(
              "Valoración:",
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 74, 75, 75)),
            ),
            trailing: RatingBar.builder(
              itemBuilder: (context, index) => const Icon(
                Icons.star, color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  valoracion = rating;
                });
              },
              itemCount: 5,
              itemSize: 35,
              allowHalfRating: true,
              unratedColor: Colors.grey,
              //unratedColor: Colors.transparent,
                initialRating: valoracion,
                updateOnDrag: true,
                tapOnlyMode: true,
            ),
          ),
        ),

        ],
    );
  }



  Widget _botones() {
    return Container(
      //alignment: Alignment.bottomCenter,
      //padding: const EdgeInsets.only(bottom: 95),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton.tonal (
                style: style,
                onPressed: () {
                  _showModal(context);
                },
                child: const Text('Aceptar', textAlign: TextAlign.center),
              ),

              FilledButton.tonal(
                style: style,
                onPressed: () {
                  _resetForm();
                },
                child: const Text('Borrar', textAlign: TextAlign.center),
              ),

              /*ElevatedButton(
                onPressed: () {
                  print("Botón de prueba presionado");
                  _showModal(context);
                },
                child: Text("Prueba"),
              ),*/
            ],
          ),
        ],
      ),
    );
  }


  void _showModal(BuildContext context) {
    if (key.currentState != null && key.currentState!.validate()) {
      key.currentState?.save();
      print("Fecha de Nacimiento: $fecha");
      print("Nombre: $nombre");
      print("Comentario: $comentario");
      print("Valoracion: $valoracion");

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Datos Ingresados:"),
                  const SizedBox(height: 10),
                  Text("Fecha: ${DateFormat('dd-MM-yyyy').format(fecha!)}"),
                  Text("Nombre: $nombre"),
                  Text("Comentario: $comentario"),
                  Text("Valoracion: $valoracion"),
                ],
              ),
            ),
          );
        },
      );
    }
  }


  void _resetForm() {
    key.currentState?.reset();
    setState(() {
      fecha = null;
      nombre = "";
      comentario = "";
      valoracion = 0;
    });
  }

}