import 'package:flutter/material.dart';

import '../../../../core/widgets/main_app_bar.dart';
import '../widgets/classroom_start_row.dart';
import '../widgets/first_part_of_row_widget.dart';

class ClassroomPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'classroom';

  const ClassroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(55), child: MainAppBar()),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          StartRow(),
          SizedBox(
            height: 30,
          ),
          FirstPartOfRowWidget(),
        ],
      )),
    );
  }
}
