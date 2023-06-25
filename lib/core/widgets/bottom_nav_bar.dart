import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_filled),
          label: 'Inicio',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_today),
          label: 'Pendientes',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}
