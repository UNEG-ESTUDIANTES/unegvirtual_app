import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:unegvirtual_app/core/widgets/scaffold_with_navigation_bar.dart';
import 'package:unegvirtual_app/core/widgets/scaffold_with_navigation_rail.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation({
    super.key = const ValueKey<String>('ScaffoldWithNestedNavigation'),
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // Navigate to initial location when tapping item
      // that is already active.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          return ScaffoldWithNavigationRail(
            body: navigationShell,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goBranch,
          );
        }

        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      },
    );
  }
}
