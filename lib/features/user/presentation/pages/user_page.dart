import 'package:flutter/material.dart';

import '../../../../core/widgets/main_app_bar.dart';
import '../widgets/basic_info_widget.dart';
import '../widgets/notes_table_start_widget.dart';
import '../widgets/notes_table_widget.dart';
import '../widgets/semester_select_widget.dart';
import '../widgets/user_data_widget.dart';

class UserPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'user';

  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(55), child: MainAppBar()),
      body: SingleChildScrollView(
          child: Column(
        children: const [
          SizedBox(
            height: 30,
          ),
          BasicInfoWidget(),
          UserDataWidget(),
          SizedBox(
            height: 30,
          ),
          SemesterSelectWidget(),
          SizedBox(height: 10),
          NotesTableStartWidget(),
          NotesTableWidget()
        ],
      )),
    );
  }
}
