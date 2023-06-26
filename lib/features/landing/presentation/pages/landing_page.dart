import 'package:flutter/material.dart';

import 'package:classroom_app/features/landing/presentation/widgets/widgets.dart';

class LandingPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'landing';

  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Image(
          image: AssetImage(
            'assets/uneg_logo.png',
          ),
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.login,
              color: Colors.white,
            ),
          ),
        ],
        scrolledUnderElevation: 1.0,
        shadowColor: Colors.black,
        backgroundColor: Colors.transparent,
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
