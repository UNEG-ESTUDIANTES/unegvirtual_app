import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:classroom_app/core/entities/entities.dart';
import 'package:classroom_app/features/course/presentation/widgets/course_section.dart';
import 'package:classroom_app/features/course/presentation/widgets/teacher_card.dart';
import 'package:classroom_app/features/course/presentation/widgets/units_list.dart';

import '../../../../core/widgets/main_app_bar.dart';

class CoursePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'course';

  const CoursePage({super.key});

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
                  const Expanded(
                    child: SingleChildScrollView(
                      child: CourseSection(
                        title: 'Hello',
                        children: [
                          UnitsList(
                            [
                              Unit(
                                name: 'Programación Orientada a Objetos',
                                number: 1,
                              ),
                            ],
                          )
                        ],
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

          return const SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: CourseSection(
              title: 'Hello',
              children: [
                TeacherCard(),
                SizedBox(height: 24),
                UnitsList(
                  [
                    Unit(
                      name: 'Programación Orientada a Objetos',
                      number: 1,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
