import 'package:flutter/material.dart';

import 'package:classroom_app/core/widgets/bottom_nav_bar.dart';
import 'package:classroom_app/core/widgets/main_app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() => currentPageIndex = index);
        },
      ),
      body: const [HomePage(), UserPage()][currentPageIndex],
    );
  }
}
