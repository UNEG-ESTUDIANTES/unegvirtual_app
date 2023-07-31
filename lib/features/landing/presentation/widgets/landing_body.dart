import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/widgets/loading_display.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/course_provider.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/careers_slider.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/footer.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/hero_section.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    final state = courseProvider.state;

    if (state is Empty) {
      courseProvider.getCourses();
      return Container();
    }

    final courses = courseProvider.courses ?? const Courses(courses: []);

    return SingleChildScrollView(
      child: Column(
        children: [
          const HeroSection(),
          const SizedBox(height: 64),
          if (state is Loading)
            const LoadingDisplay()
          else
            CareersSlider(courses),
          const SizedBox(height: 64),
          const Footer(),
        ],
      ),
    );
  }
}
