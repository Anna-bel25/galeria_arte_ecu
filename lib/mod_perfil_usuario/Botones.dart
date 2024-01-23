import 'package:flutter/material.dart';

class Botones extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const Botones({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          backgroundColor: const Color.fromARGB(255, 18, 127, 116)
        ),
        child: Text(text),
        onPressed: onClicked,
        
      );
}