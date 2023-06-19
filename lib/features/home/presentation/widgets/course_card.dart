import 'package:flutter/material.dart';

import 'package:classroom_app/features/home/data/models/course_model.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final double maxHeight;

  const CourseCard(
    this.course, {
    super.key,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: maxHeight * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(course.sumary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
