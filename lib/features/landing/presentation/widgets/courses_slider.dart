import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:unegvirtual_app/core/entities/course.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/course_provider.dart';

class CoursesSlider extends StatelessWidget {
  const CoursesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final courseProvider = context.watch<CourseProvider>();

    // Fetch courses.
    if (courseProvider.state is Empty) {
      courseProvider.getCourses();
      return Container();
    }

    // Take the courses.
    final List<Course> courses =
        courseProvider.courses != null ? courseProvider.courses!.courses : [];

    // Select the child to display.
    Widget child;

    if (courseProvider.state is Loading) {
      child = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (courses.isNotEmpty) {
      child = ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final course = courses[index];

          return SizedBox(
            width: 300,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description,
                      maxLines: getValueForScreenType(
                        context: context,
                        mobile: 1,
                        tablet: 2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: courses.length,
      );
    } else {
      child = const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Text('No hay cursos disponibles.'),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Cursos',
              style: textTheme.headlineSmall,
            ),
          ),
          SizedBox(
            height: getValueForScreenType(
              context: context,
              mobile: 16,
              tablet: 24,
            ),
          ),
          SizedBox(
            height: getValueForScreenType<double>(
              context: context,
              mobile: 100,
              tablet: 125,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
