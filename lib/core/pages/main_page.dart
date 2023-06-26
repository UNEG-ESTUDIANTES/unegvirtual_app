import 'package:flutter/material.dart';

import 'package:classroom_app/core/widgets/bottom_nav_bar.dart';
import 'package:classroom_app/core/widgets/main_app_bar.dart';
import 'package:classroom_app/core/widgets/nav_bar.dart';
import 'package:classroom_app/features/home/presentation/pages/home_page.dart';
import 'package:classroom_app/features/user/presentation/pages/user_page.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Scaffold(
              body: [
            _DesktopLayout(
              selectedIndex: currentPageIndex,
              onDestinationSelected: onDestinationSelected,
              child: const HomePage(),
            ),
            _DesktopLayout(
              selectedIndex: currentPageIndex,
              onDestinationSelected: onDestinationSelected,
              child: const UserPage(),
            ),
          ][currentPageIndex]);
        }

        return Scaffold(
          appBar: const MainAppBar(),
          bottomNavigationBar: BottomNavBar(
            selectedIndex: currentPageIndex,
            onDestinationSelected: onDestinationSelected,
          ),
          body: [
            const HomePage(),
            const UserPage(),
          ][currentPageIndex],
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
        Expanded(child: child),
      ],
    );
  }
}
