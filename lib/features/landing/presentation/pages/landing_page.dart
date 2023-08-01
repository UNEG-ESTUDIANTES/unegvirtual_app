import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:unegvirtual_app/features/auth/presentation/pages/login_page.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/widgets.dart';

class LandingPage extends StatefulWidget {
  /// The page route name.
  static const routeName = '/landing';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const Image(
          image: AssetImage(
            'assets/uneg_logo.png',
          ),
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(LogInPage.routeName),
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
          children: [
            HeroSection(height: height * 0.6),
            const SizedBox(height: 32),
            const CoursesSlider(),
            SizedBox(height: height * 0.4),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
