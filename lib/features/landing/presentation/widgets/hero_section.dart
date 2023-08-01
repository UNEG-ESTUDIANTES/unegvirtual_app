import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    final textStyle = getValueForScreenType<TextStyle?>(
      context: context,
      mobile: textTheme.headlineLarge,
      desktop: textTheme.displayMedium,
    );

    return Container(
      alignment: getValueForScreenType<AlignmentGeometry>(
        context: context,
        mobile: Alignment.centerLeft,
        desktop: Alignment.center,
      ),
      height: height * 0.6,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/landing_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          'Ayudando a formar las mentes del mañana',
          style: textStyle?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
