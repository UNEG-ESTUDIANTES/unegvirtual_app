import 'package:flutter/material.dart';

class ScaffoldWithNavigationRail extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.school_outlined),
                label: Text('Cursos'),
                selectedIcon: Icon(Icons.school),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group_outlined),
                label: Text('Usuarios'),
                selectedIcon: Icon(Icons.group),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outlined),
                label: Text('Perfil'),
                selectedIcon: Icon(Icons.person),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
