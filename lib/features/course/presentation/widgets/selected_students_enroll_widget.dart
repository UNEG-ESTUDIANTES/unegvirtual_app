import 'package:flutter/material.dart';

import 'package:classroom_app/core/entities/user.dart';

class SelectedStudents extends StatefulWidget {
  const SelectedStudents({
    super.key,
    required List<User> selectedStudents,
  }) : _selectedStudents = selectedStudents;

  final List<User> _selectedStudents;

  @override
  State<SelectedStudents> createState() => _SelectedStudentsState();
}

class _SelectedStudentsState extends State<SelectedStudents> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: widget._selectedStudents.isEmpty
          ? const Center(
              child: Text('No has seleccionado a ningún estudiante'),
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final student = widget._selectedStudents[index];

                return Column(
                  children: [
                    const CircleAvatar(
                      radius: 32,
                    ),
                    const SizedBox(height: 8),
                    Text('${student.firstName} ${student.lastName}'),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: widget._selectedStudents.length,
            ),
    );
  }
}
