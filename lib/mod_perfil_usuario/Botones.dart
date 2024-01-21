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
          backgroundColor: Colors.grey
        ),
        child: Text(text),
        onPressed: onClicked,
        
      );
}