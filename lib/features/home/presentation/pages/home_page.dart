import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:classroom_app/features/home/presentation/provider/home_provider.dart';
import 'package:classroom_app/features/home/presentation/widgets/course_card.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/page_state.dart';
import '../../../../core/services/notifications_service.dart';
import '../../../course/presentation/pages/course_page.dart';

class HomePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size);
    final textTheme = Theme.of(context).textTheme;
    final auth = context.read<AuthProvider>().auth!;
    final homeProvider = context.watch<HomeProvider>();
    final state = homeProvider.state;

    int gridCrossAxisCount = 0;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        gridCrossAxisCount = 3;
        break;

      case DeviceScreenType.tablet:
        gridCrossAxisCount = 2;
        break;

      case DeviceScreenType.mobile:
        gridCrossAxisCount = 1;
        break;

      default:
        gridCrossAxisCount = 1;
    }

    if (state is Empty) {
      homeProvider.enroledCourses(auth.accessToken);
      return Container();
    }

    if (state is Error) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => NotificationsService.showSnackBar(state.message),
      );
    }

    final courses =
        state is Loaded ? homeProvider.courses! : const Courses(courses: []);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola ${auth.user.firstName} ${auth.user.lastName}',
            style: textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          Text(
            'Mis Cursos',
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          if (courses.courses.isEmpty)
            const Center(
              child: Text('No estas inscrito en ningun curso'),
            )
          else
            GridView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCrossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 200,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CoursePage(course: courses.courses[index])),
                    );
                  },
                  child: CourseCard(
                    course: courses.courses[index],
                    completedPercentage: 32,
                  ),
                );
              },
              itemCount: courses.courses.length,
            )
        ],
      ),
    );
  }
}
