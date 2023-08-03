import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/providers/auth_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/providers.dart';
import 'package:unegvirtual_app/injection_container.dart' as di;

class CoursesPage extends StatelessWidget {
  /// The page route name.
  static const routeName = '/courses';

  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.sl<EnrolledCoursesProvider>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cursos'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'ej: Programación',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  label: const Text('Curso'),
                ),
              ),
              const SizedBox(height: 32),
              const _CoursesList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoursesList extends StatelessWidget {
  const _CoursesList();

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>().auth!;
    final provider = context.watch<EnrolledCoursesProvider>();

    // Fetch courses.
    if (provider.state is Empty) {
      provider.getEnrolledCourses(accessToken: auth.accessToken);
      return Container();
    }

    if (provider.state is Loading) {
      return const CircularProgressIndicator();
    }

    final courses = provider.enrolledCourses?.courses ?? [];

    if (courses.isEmpty) {
      return const Text('No estás inscrito a ningun curso.');
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final course = courses[index];

        return ListTile(
          title: Text(course.name),
          dense: false,
          subtitle: Text(course.description),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: courses.length,
    );
  }
}
