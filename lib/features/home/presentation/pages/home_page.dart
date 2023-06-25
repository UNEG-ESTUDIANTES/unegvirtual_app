import 'package:flutter/material.dart';

import 'package:classroom_app/core/widgets/bottom_nav_bar.dart';
import 'package:classroom_app/core/widgets/main_app_bar.dart';

class HomePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Hola, Taylor Swift',
              style: textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
