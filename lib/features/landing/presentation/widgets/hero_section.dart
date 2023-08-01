import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

class HeroSection extends StatelessWidget {
  final double height;

  const HeroSection({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final textStyle = getValueForScreenType<TextStyle?>(
      context: context,
      mobile: textTheme.headlineLarge,
      tablet: textTheme.displaySmall,
      desktop: textTheme.displayMedium,
    );

    return Container(
      alignment: getValueForScreenType<AlignmentGeometry>(
        context: context,
        mobile: Alignment.centerLeft,
        tablet: Alignment.center,
      ),
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xff023272),
        image: DecorationImage(
          image: AssetImage('assets/landing_background.jpg'),
          opacity: 0.40,
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
          textAlign: getValueForScreenType(
            context: context,
            mobile: TextAlign.left,
            tablet: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
