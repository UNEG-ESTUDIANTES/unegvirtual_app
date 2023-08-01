import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/widgets/loading_display.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/course_provider.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/courses_slider.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/footer.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/hero_section.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
          HeroSection(height: height * 0.6),
          const SizedBox(height: 32),
          if (state is Loading)
            const LoadingDisplay()
          else
            CoursesSlider(courses),
          SizedBox(height: height * 0.4),
          const Footer(),
        ],
      ),
    );
  }
}
