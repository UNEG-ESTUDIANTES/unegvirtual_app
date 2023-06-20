import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  /// The [title] of the section.
  final String title;

  /// The [child] to be displayed.
  final Widget child;

  const Section({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            title,
            style: textTheme.headlineMedium?.copyWith(
              color: const Color(0xff23354E),
            ),
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
