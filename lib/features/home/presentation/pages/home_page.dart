import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:classroom_app/core/models/course_model.dart';

import 'package:classroom_app/features/home/presentation/widgets/course_card.dart';

class HomePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size);
    final textTheme = Theme.of(context).textTheme;

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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola, Taylor Swift',
            style: textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          Text(
            'Mis Cursos',
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
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
              return CourseCard(
                course: CourseElement(
                    id: '12345',
                    name: 'programacion',
                    description: 'aprende',
                    teacherId: '123'),
                completedPercentage: 32,
              );
            },
            itemCount: 4,
          )
        ],
      ),
    );
  }
}
