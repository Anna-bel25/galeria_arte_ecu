import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final Function(int) onItemSelected;

  CustomMenu({required this.items, required this.selectedIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        items.length,
        (index) => IconButton(
          icon: Icon(
            index == 0
                ? Icons.star
                : index == 1
                    ? Icons.comment
                    : Icons.forum,
            color: index == selectedIndex ? Colors.blue : Colors.grey,
          ),
          onPressed: () {
            onItemSelected(index);
          },
        ),
      ),
    );
  }
}





/*import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'comentario.dart';
import 'valoracion.dart';
import 'foro.dart';


class Menu extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChange;
  final BuildContext Function() getContext;
  final List<Color> colors;

  Menu({
    required this.currentIndex,
    required this.onTabChange,
    required this.getContext,
    required this.colors,
  });

  @override
  _MenuState createState() => _MenuState();
}


class _MenuState extends State<Menu> {
  int _currentIndex = 0;

  void _onTabChange(int index) {
    widget.onTabChange(index);
      setState(() {
      _currentIndex = index;
    });
    print('Índice de pestaña cambiado a: $index');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _getPage(index)),
    );
  }


Widget _getPage(int index) {
  switch (index) {
    case 0:
      return const ForoPage(title: 'Foro');
    case 1:
      return const ComentarioPage(title: 'Comentario');
    case 2:
      return const ValoracionPage(title: 'Obras más valoradas');
    default:
      return const ForoPage(title: 'Foro');
  }
}



  @override
  Widget build(BuildContext context) {
    return GNav(
      color: widget.colors[_currentIndex],
      tabBackgroundColor: widget.colors[_currentIndex],
      selectedIndex: _currentIndex,
      //onTabChange: _onTabChange,
      tabs: const [
        GButton(
          icon: Icons.forum_outlined,
          text: 'Foro',
          iconActiveColor: Colors.white,
          textColor: Colors.white,
        ),
        GButton(
          icon: Icons.comment_outlined,
          text: 'Comentario',
          iconActiveColor: Colors.white,
          textColor: Colors.white,
        ),
        GButton(
          icon: Icons.star_border,
          text: 'Valoración',
          iconActiveColor: Colors.white,
          textColor: Colors.white,
        ),
      ],
    );
  }
}*/


          /*body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
            ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: Icon(Icons.menu),
            ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
            ),
        ],
      ),*/
          
        