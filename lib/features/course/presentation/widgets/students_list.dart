import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/features/course/presentation/providers/students_enrollment_provider.dart';
import 'package:classroom_app/features/course/presentation/widgets/selected_students_enroll_widget.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/providers/page_state.dart';
import '../providers/course_provider.dart';

class StudentsListWidget extends StatelessWidget {
  final List<User> students;
  final Course course;

  const StudentsListWidget({
    super.key,
    required this.students,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final studentsEnrollmentProvider =
        context.watch<StudentsEnrollmentProvider>();
    final courseProviderState = context.read<CourseProvider>().state;

    if (courseProviderState is Loading) {
      return const CircularProgressIndicator();
    }

    return Column(
      children: [
        SelectedStudents(
          selectedStudents: studentsEnrollmentProvider.selectedStudents,
        ),
        const Divider(),
        if (students.isEmpty)
          const Center(
            child: Text('No hay estudiantes registrados'),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final student = students[index];

                return GestureDetector(
                  onTap: () {
                    studentsEnrollmentProvider.toggleStudent(student);
                  },
                  child: ListTile(
                    title: Text(
                      '${student.firstName} ${student.lastName} (${student.identityCard})',
                    ),
                    leading: Checkbox(
                      value: studentsEnrollmentProvider.selectedStudents
                          .contains(student),
                      onChanged: (_) {
                        studentsEnrollmentProvider.toggleStudent(student);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
