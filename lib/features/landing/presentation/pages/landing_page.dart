import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:unegvirtual_app/features/auth/presentation/pages/login_page.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/landing_body.dart';

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
      body: const LandingBody(),
    );
  }
}
