import 'package:flutter/material.dart';

import '../../../../core/widgets/main_app_bar.dart';
import '../widgets/basic_info_widget.dart';
import '../widgets/user_data_widget.dart';

class UserPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'user';

  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: MainAppBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const BasicInfoWidget(),
            const UserDataWidget(),
            const SizedBox(height: 30),
            TextButton(
              onPressed: (() {}),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                fixedSize: const Size(170, 60),
              ),
              child: const Text(
                "Semestre 1",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                SizedBox(width: 50),
                Text(
                  "Pensum",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: SizedBox(width: 1)),
                Text(
                  "U.C",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 20),
                Text(
                  "U.C",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 20),
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      const SizedBox(width: 34),
                      Text(
                        "Materia $index",
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const Expanded(child: SizedBox(width: 1)),
                      const Text(
                        "10",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(width: 25),
                      const Text(
                        "10",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
