import 'package:flutter/material.dart';
import 'package:whowhats/reusable/lib_colors.dart';

class SplitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green], // Couleurs des deux côtés
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), // Radius coin en bas à gauche
            bottomRight: Radius.circular(20), // Radius coin en bas à droite
          ),
        ),
      ),
    );
  }
}
