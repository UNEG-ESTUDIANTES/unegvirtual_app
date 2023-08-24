import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:unegvirtual_app/core/providers/auth_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/features/course/presentation/pages/pages.dart';
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
        body: const _CoursesList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(
            '$routeName/${CreateCoursePage.routeName}',
          ),
          child: const Icon(Icons.add),
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
    final textTheme = Theme.of(context).textTheme;

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
      return const Center(
        child: Text('No estás inscrito a ningun curso.'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(24.0),
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getValueForScreenType<int>(
          context: context,
          mobile: 1,
          tablet: 2,
          desktop: 3,
        ),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 100,
      ),
      itemBuilder: (context, index) {
        final course = courses[index];

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  course.name,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  course.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
      itemCount: courses.length,
    );
  }
}
