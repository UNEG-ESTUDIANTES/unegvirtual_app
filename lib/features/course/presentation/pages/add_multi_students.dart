import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/entities/user.dart';
import 'package:unegvirtual_app/core/providers/auth_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/services/notifications_service.dart';
import 'package:unegvirtual_app/features/course/domain/entities/multi_enroll.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/multi_students_enroll.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/course_provider.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/students_enrollment_provider.dart';

import '../../../../core/entities/course.dart';
import '../widgets/students_list.dart';

class MultiStudentsEnrollPage extends StatefulWidget {
  /// The page route name.
  static const routeName = 'multi-students-enroll';

  final Course course = const Course(
    id: '64bb26ac475b585eb5f32952',
    name: 'Modelaje',
    description: 'Im terking on the runway',
    teacherId: '64b1f3aaf0e763d6de7fe836',
  );

  const MultiStudentsEnrollPage({Key? key}) : super(key: key);

  @override
  State<MultiStudentsEnrollPage> createState() =>
      _MultiStudentsEnrollPageState();
}

class _MultiStudentsEnrollPageState extends State<MultiStudentsEnrollPage> {
  Future<void> _onSubmit() async {
    final auth = context.read<AuthProvider>().auth;

    if (auth == null) {
      NotificationsService.showSnackBar(
        'Debe estar autenticado para realizar la acción',
      );

      return;
    }

    final selectedStudents =
        context.read<StudentsEnrollmentProvider>().selectedStudents;

    List<String> studentIds = selectedStudents.map((u) => u.id).toList();

    final multienroll = MultiEnroll(
      courseId: widget.course.id,
      studentIds: studentIds,
    );

    // Try to add the students to the course.
    await context.read<CourseProvider>().multiStudentsEnroll(
          MultiStudentsEnrollParams(
            accessToken: auth.accessToken,
            multiEnroll: multienroll,
          ),
        );

    if (!mounted) return;

    final courseProviderState = context.read<CourseProvider>().state;
    String snackBarMessage;

    // Change state and snackbar according to state.
    if (courseProviderState is Error) {
      snackBarMessage = courseProviderState.message;
    } else {
      snackBarMessage = 'Ha inscrito estudiantes con éxito';
      context.read<StudentsEnrollmentProvider>().reset();
    }

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    // Display the snackbar.
    NotificationsService.showSnackBar(snackBarMessage);
  }

  @override
  Widget build(BuildContext context) {
    final courseProviderState = context.watch<CourseProvider>().state;
    final studentsEnrollmentProvider =
        context.watch<StudentsEnrollmentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir estudiantes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: StudentsListWidget(
          students: const [
            User(
              id: '64b485bd66d7f87437caaf40',
              firstName: 'Winter',
              lastName: 'Song',
              identityCard: '45147258',
              email: 'wintersong@gmail.com',
            ),
            User(
                id: '96369258',
                firstName: 'Yvex',
                lastName: 'Loona',
                identityCard: '96369258',
                email: 'yvexloona@gmail.com'),
            User(
                id: '64b485f266d7f87437caaf46',
                firstName: 'Chuu',
                lastName: 'Loona',
                identityCard: '74741852',
                email: 'chuuloona@gmail.com'),
            User(
              id: '64b4864866d7f87437caaf49',
              firstName: 'Jin',
              lastName: 'Soul',
              identityCard: '78789456',
              email: 'jinsoul@gmail.com',
            ),
          ],
          course: widget.course,
        ),
      ),
      floatingActionButton: studentsEnrollmentProvider.isSubmittable
          ? FloatingActionButton(
              onPressed: courseProviderState is Loading ? null : _onSubmit,
              child: const Icon(Icons.check),
            )
          : null,
    );
  }
}
