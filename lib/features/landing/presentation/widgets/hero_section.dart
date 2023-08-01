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
      desktop: textTheme.displayMedium,
    );

    return Container(
      alignment: getValueForScreenType<AlignmentGeometry>(
        context: context,
        mobile: Alignment.centerLeft,
        desktop: Alignment.center,
      ),
      height: height,
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
