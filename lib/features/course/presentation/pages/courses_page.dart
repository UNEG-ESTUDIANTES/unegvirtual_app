import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  /// The page route name.
  static const routeName = '/courses';

  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
    );
  }
}
