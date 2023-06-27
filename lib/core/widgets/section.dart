import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget child;
  final double spacing;

  const Section({
    super.key,
    required this.title,
    this.spacing = 16.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headlineMedium,
        ),
        SizedBox(height: spacing),
        child,
      ],
    );
  }
}
