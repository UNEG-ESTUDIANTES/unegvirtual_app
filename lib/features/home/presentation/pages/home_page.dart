import 'package:flutter/material.dart';

import 'package:classroom_app/core/widgets/bottom_nav_bar.dart';
import 'package:classroom_app/core/widgets/main_app_bar.dart';
import 'package:classroom_app/features/home/presentation/widgets/course_card.dart';
import 'package:classroom_app/features/landing/data/models/course_model.dart';

class HomePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
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
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 200,
              ),
              itemBuilder: (context, index) {
                return const CourseCard(
                  course: Course(
                    name: 'Tecnicas de Programación I',
                    sumary: '1 2 3',
                  ),
                  completedPercentage: 32,
                );
              },
              itemCount: 4,
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
