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
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isDesktop ? null : const MainAppBar(),
      bottomNavigationBar: isDesktop
          ? null
          : BottomNavBar(
              selectedIndex: currentPageIndex,
              onDestinationSelected: onDestinationSelected,
            ),
      body: [
        _MainPageItem(
          selectedIndex: currentPageIndex,
          onDestinationSelected: onDestinationSelected,
          child: const HomePage(),
        ),
        _MainPageItem(
          selectedIndex: currentPageIndex,
          onDestinationSelected: onDestinationSelected,
          child: const UserPage(),
        ),
      ][currentPageIndex],
    );
  }
}

class _MainPageItem extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  const _MainPageItem({
    required this.child,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop)
          NavBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
          ),
        Expanded(child: child),
      ],
    );
  }
}
