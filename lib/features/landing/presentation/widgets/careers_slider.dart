import 'package:classroom_app/core/entities/courses.dart';
import 'package:flutter/material.dart';

import 'package:classroom_app/features/landing/presentation/widgets/career_card.dart';
import 'package:classroom_app/features/landing/presentation/widgets/section.dart';

class CareersSlider extends StatelessWidget {
  /// The [careers] to display.
  final Courses courses;

  const CareersSlider(this.courses, {super.key});

  @override
  Widget build(BuildContext context) {
    const height = 250.0;

    return Section(
      title: 'Carreras Universitarias',
      child: courses.courses.isNotEmpty
          ? SizedBox(
              height: height,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CourseCard(
                  courses.courses[index],
                  maxHeight: height,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: courses.courses.length,
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: const Text('No hay carreras disponibles'),
            ),
    );
  }
}
