import 'package:flutter/material.dart';

import 'package:unegvirtual_app/features/landing/presentation/widgets/courses_slider.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/footer.dart';
import 'package:unegvirtual_app/features/landing/presentation/widgets/hero_section.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          HeroSection(height: height * 0.6),
          const SizedBox(height: 32),
          const CoursesSlider(),
          SizedBox(height: height * 0.4),
          const Footer(),
        ],
      ),
    );
  }
}
