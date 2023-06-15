import 'package:flutter/material.dart';

import 'nav_bar_button.dart';

class NavBarMenu extends StatelessWidget {
  const NavBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 59, 165, 192),
      child: Column(children: [
        SizedBox(height: 100),
        Container(
            child: Image.asset('assets/uneg_logo.png', fit: BoxFit.cover)),
        SizedBox(height: 20),
        NavBarButton(icon: Icons.home, name: 'Inicio'),
        SizedBox(height: 20),
        NavBarButton(icon: Icons.book, name: 'Cursos'),
        SizedBox(height: 20),
        NavBarButton(icon: Icons.calendar_month, name: 'Pendientes'),
        SizedBox(height: 20),
        NavBarButton(icon: Icons.exit_to_app, name: 'Log out'),
      ]),
    );
  }
}
