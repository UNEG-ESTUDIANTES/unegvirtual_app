import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart';
import 'package:classroom_app/features/course/domain/usecases/multi_students_enroll.dart';
import 'package:classroom_app/features/course/presentation/widgets/selected_students_enroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/page_state.dart';
import '../../../../core/providers/user_provider.dart';
import '../providers/course_provider.dart';

class StudentsListWidget extends StatefulWidget {
  final List<User> listaEstudiantes;
  final Course course;

  const StudentsListWidget(
      {super.key, required this.listaEstudiantes, required this.course});

  @override
  State<StudentsListWidget> createState() => _StudentsListWidgetState();
}

class _StudentsListWidgetState extends State<StudentsListWidget> {
  final List<User> _alumnosSeleccionados = [];

  void _toggleAlumno(User id) {
    setState(() {
      if (_alumnosSeleccionados.contains(id)) {
        _alumnosSeleccionados.remove(id);
      } else {
        _alumnosSeleccionados.add(id);
      }
    });
  }

  void _resetForm() {
    _alumnosSeleccionados.clear;
  }

  Future<void> _onSubmit() async {
    print('submit');
    final authProviderState = context.read<AuthProvider>().accessToken!;
    final userProviderState = context.read<UserProvider>().user!.id;

    List<String> alumnsId = _alumnosSeleccionados.map((u) => u.id).toList();

    final multienroll =
        MultiEnroll(courseId: widget.course.id, studentIds: alumnsId);

    print('hola');

    // Try to add the students to the course.
    await context.read<CourseProvider>().multiStudentsEnroll(
        MultiStudentsEnrollParams(
            accessToken: authProviderState, multiEnroll: multienroll));

    print('paso');

    if (!mounted) return;

    print('montado');

    setState(() {});

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final courseProviderState = context.read<CourseProvider>().state;
    if (courseProviderState is Loading) {
      return CircularProgressIndicator();
    } else {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectedStudentsRowWIdget(
                alumnosSeleccionados: _alumnosSeleccionados),
            Expanded(
              child: ListView.builder(
                itemCount: widget.listaEstudiantes.length,
                itemBuilder: (context, index) {
                  final alumno = widget.listaEstudiantes[index];
                  return ListTile(
                    title: Text(
                        '${alumno.identityCard} | ${alumno.firstName} ${alumno.lastName} | ${alumno.email}'),
                    leading: Checkbox(
                      value: _alumnosSeleccionados.contains(alumno),
                      onChanged: (value) {
                        _toggleAlumno(alumno);
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _onSubmit();
              },
              child: const Text('Agregar Estudiantes'),
            ),
          ],
        ),
      );
    }
  }
}
