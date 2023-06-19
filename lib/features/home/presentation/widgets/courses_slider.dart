import 'package:flutter/material.dart';

import 'package:classroom_app/features/home/data/models/course_model.dart';
import 'package:classroom_app/features/home/presentation/widgets/course_card.dart';
import 'package:classroom_app/features/home/presentation/widgets/section.dart';

class CoursesSlider extends StatelessWidget {
  final List<Course> courses;

  const CoursesSlider(this.courses, {super.key});

  @override
  Widget build(BuildContext context) {
    const height = 250.0;

    return Section(
      title: 'Carreras Universitarias',
      child: courses.isNotEmpty
          ? SizedBox(
              height: height,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CourseCard(
                  courses[index],
                  maxHeight: height,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: courses.length,
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: const Text('No hay cursos disponibles'),
            ),
    );
  }
}
