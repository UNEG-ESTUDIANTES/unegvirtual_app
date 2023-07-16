import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/widgets/loading_display.dart';
import 'package:classroom_app/features/landing/domain/entities/course.dart';
import 'package:classroom_app/features/landing/presentation/providers/landing_provider.dart';
import 'package:classroom_app/features/landing/presentation/widgets/careers_slider.dart';
import 'package:classroom_app/features/landing/presentation/widgets/footer.dart';
import 'package:classroom_app/features/landing/presentation/widgets/hero_section.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final landingProvider = context.watch<LandingProvider>();
    final state = landingProvider.state;

    if (state is Empty) {
      landingProvider.getCoursesList();
      return Container();
    }

    if (state is Loading) return const LoadingDisplay();

    final courses = state is Loading
        ? landingProvider.courses!
        : const Courses(courses: []);

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
