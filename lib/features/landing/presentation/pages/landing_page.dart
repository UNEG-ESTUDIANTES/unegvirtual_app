import 'package:flutter/material.dart';

import 'package:classroom_app/features/auth/presentation/pages/login_page.dart';
import 'package:classroom_app/features/landing/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:classroom_app/core/widgets/loading_display.dart';

import '../notifiers/landing_notifier.dart';

class LandingPage extends StatefulWidget {
  /// The page route name.
  static const routeName = 'landing';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100), child: LandingAppBar()),
      body: _body(),
    );
  }

  Widget _body() {
    final isLoading = context.select((LandingNotifier n) => n.isLoading);
    final error = context.select((LandingNotifier n) => n.error);
    final courses = context.select((LandingNotifier n) => n.courses);

    if (!isLoading!) {
      return SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
            SizedBox(height: 64),
            CareersSlider(courses!),
            SizedBox(height: 64),
            Footer(),
          ],
        ),
      );
    } else if (isLoading) {
      context.read<LandingNotifier>().getCoursesList();
      return LoadingDisplay();
    } else {
      return Container();
    }
  }
}

class LandingAppBar extends StatelessWidget {
  const LandingAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          onPressed: () => Navigator.pushNamed(context, LogInPage.routeName),
          icon: const Icon(
            Icons.login,
            color: Colors.white,
          ),
        ),
      ],
      scrolledUnderElevation: 1.0,
      shadowColor: Colors.black,
      backgroundColor: Colors.transparent,
    );
  }
}
