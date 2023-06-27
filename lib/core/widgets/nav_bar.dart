import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  /// The [selectedIndex] of the sidebar.
  final int selectedIndex;

  /// The method to execute [onDestinationSelected].
  final void Function(int)? onDestinationSelected;

  const NavBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          label: Text('Inicio'),
          selectedIcon: Icon(Icons.home),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outlined),
          label: Text('Perfil'),
          selectedIcon: Icon(Icons.person),
        ),
      ],
    );
  }
}
