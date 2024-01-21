import 'package:flutter/material.dart';

class ivetteView extends StatefulWidget {
  const ivetteView({super.key});

  @override
  State<ivetteView> createState() => _ivetteViewViewState();
}

class _ivetteViewViewState extends State<ivetteView> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Current motors: $count'),
          FilledButton.tonal(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              child: const Icon(Icons.add)),
        ],
      ),
    );
  }
}