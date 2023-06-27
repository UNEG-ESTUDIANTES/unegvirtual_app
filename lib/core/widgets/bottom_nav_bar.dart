import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

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
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
