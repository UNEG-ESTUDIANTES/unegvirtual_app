import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/widgets/loading_display.dart';
import 'package:classroom_app/features/auth/presentation/pages/login_page.dart';
import 'package:classroom_app/features/landing/domain/entities/course.dart';
import 'package:classroom_app/features/landing/presentation/widgets/widgets.dart';

import '../providers/landing_provider.dart';

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
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final landingProvider = context.watch<LandingProvider>();
    final state = landingProvider.state;

    // Get courses.
    if (state is Empty) {
      landingProvider.getCoursesList();
      return Container();
    }

    if (state is Loading) {
      return const LoadingDisplay();
    }

    // Display failure in snackbar.
    if (state is Error) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
    }

    // The courses to display
    final courses =
        state is Loaded ? landingProvider.courses! : const Courses(courses: []);

    return SingleChildScrollView(
      child: Column(
        children: [
          const HeroSection(),
          const SizedBox(height: 64),
          CareersSlider(courses),
          const SizedBox(height: 64),
          const Footer(),
        ],
      ),
    );
  }
}
