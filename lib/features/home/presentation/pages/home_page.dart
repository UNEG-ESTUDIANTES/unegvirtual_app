import 'package:flutter/material.dart';

import 'package:classroom_app/features/home/presentation/widgets/widgets.dart';

import '../../../../core/widgets/main_app_bar.dart';

class HomePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: MainAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroSection(),
            SizedBox(height: 64),
            CoursesSlider([]),
            SizedBox(height: 64),
            Footer(),
          ],
        ),
      ),
    );
  }
}
