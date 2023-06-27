import 'package:flutter/material.dart';

class CourseSection extends StatelessWidget {
  final String title;
  final Widget child;

  const CourseSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleWrapper(title),
        const SizedBox(height: 24),
        child,
      ],
    );
  }
}

class _TitleWrapper extends StatelessWidget {
  final String title;

  const _TitleWrapper(this.title);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            blurRadius: 20.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: textTheme.headlineLarge?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
