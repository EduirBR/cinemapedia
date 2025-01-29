import 'package:flutter/material.dart';

class CustomBottonNavigationBar extends StatelessWidget {
  const CustomBottonNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 15,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Categorias'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Faboritos'),
      ],
    );
  }
}
