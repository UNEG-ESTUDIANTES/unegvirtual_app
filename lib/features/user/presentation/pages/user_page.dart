import 'package:flutter/material.dart';

import '../widgets/basic_info_widget.dart';
import '../widgets/user_data_widget.dart';

const List<int> semesters = [1, 2, 3];

class UserPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'user';

  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BasicInfoWidget(),
          const Divider(height: 32),
          const UserDataWidget(),
          const Divider(height: 32),
          DropdownButton<int>(
            hint: const Text('Semestre'),
            items: semesters.map((semester) {
              return DropdownMenuItem<int>(
                value: semester,
                child: Text('Semestre $semester'),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Pensum',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'U.C.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(
                      Text('Materia I'),
                    ),
                    DataCell(
                      Text('2'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
