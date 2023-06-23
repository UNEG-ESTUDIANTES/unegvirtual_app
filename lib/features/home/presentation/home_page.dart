import 'package:flutter/material.dart';

import 'package:classroom_app/core/widgets/main_app_bar.dart';

class HomePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: MainAppBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: const [
            Text('Hola, Taylor Swift.'),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'Cursos',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Pendientes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Usuarios',
          ),
        ],
      ),
    );
  }
}
