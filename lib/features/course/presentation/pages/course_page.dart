import 'package:flutter/material.dart';

import '../../../../core/widgets/main_app_bar.dart';
import '../widgets/first_part_of_row_widget.dart';

class CoursePage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'course';

  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: FirstPartOfRowWidget(),
      ),
    );
  }
}
