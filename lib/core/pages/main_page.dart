import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:unegvirtual_app/core/widgets/bottom_nav_bar.dart';
import 'package:unegvirtual_app/core/widgets/main_app_bar.dart';
import 'package:unegvirtual_app/core/widgets/nav_bar.dart';
import 'package:unegvirtual_app/features/home/presentation/pages/home_page.dart';
import 'package:unegvirtual_app/features/user/presentation/pages/register_page.dart';
import 'package:unegvirtual_app/features/user/presentation/pages/user_page.dart';
import 'package:unegvirtual_app/features/user/presentation/pages/users_page.dart';

class NavDestination {
  final Widget child;
  final FloatingActionButton? floatingActionButton;

  NavDestination({
    required this.child,
    this.floatingActionButton,
  });
}

class MainPage extends StatefulWidget {
  /// The page route name.
  static const routeName = 'main';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  void onDestinationSelected(int index) {
    setState(() => currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<NavDestination> destinations = [
      NavDestination(
        child: const HomePage(),
      ),
      NavDestination(
        child: const UsersPage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RegisterPage.routeName),
          child: const Icon(Icons.add),
        ),
      ),
      NavDestination(
        child: const UserPage(),
      ),
    ];

    final destination = destinations[currentPageIndex];

    final desktopDestinations = destinations.map((destination) {
      return _DesktopLayout(
        selectedIndex: currentPageIndex,
        onDestinationSelected: onDestinationSelected,
        child: destination.child,
      );
    }).toList();

    final mobileDestinations = destinations.map((destination) {
      return destination.child;
    }).toList();

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          return Scaffold(
            body: desktopDestinations[currentPageIndex],
            floatingActionButton: destination.floatingActionButton,
          );
        }

        return Scaffold(
          appBar: const MainAppBar(),
          bottomNavigationBar: BottomNavBar(
            selectedIndex: currentPageIndex,
            onDestinationSelected: onDestinationSelected,
          ),
          body: mobileDestinations[currentPageIndex],
          floatingActionButton: destination.floatingActionButton,
        );
      },
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  const _DesktopLayout({
    required this.child,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NavBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
        ),
        const VerticalDivider(width: 1, thickness: 1),
        Expanded(child: child),
      ],
    );
  }
}
