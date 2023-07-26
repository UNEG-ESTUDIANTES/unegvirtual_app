import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/core/entities/entities.dart';
import 'package:classroom_app/core/widgets/section.dart';
import 'package:classroom_app/features/course/presentation/widgets/course_section.dart';
import 'package:classroom_app/features/course/presentation/widgets/teacher_card.dart';
import 'package:classroom_app/features/course/presentation/widgets/units_list.dart';

import '../../../../core/widgets/main_app_bar.dart';

// Sample data

const units = [
  Unit(
    name: 'Unidad 1',
    number: 1,
  ),
  Unit(
    name: 'Unidad 2',
    number: 2,
  ),
  Unit(
    name: 'Unidad 3',
    number: 3,
  ),
];

class CoursePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'course';

  final Course course;

  const CoursePage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isDesktop) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: CourseSection(
                        title: course.name,
                        child: const Section(
                          title: 'Unidades',
                          child: UnitsList(units),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  SizedBox(
                    width: sizingInformation.screenSize.width * 0.25,
                    child: const TeacherCard(),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: CourseSection(
              title: course.name,
              child: Column(
                children: const [
                  TeacherCard(),
                  SizedBox(height: 24),
                  Section(
                    title: 'Unidades',
                    child: UnitsList(units),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
