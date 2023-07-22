import 'package:classroom_app/core/entities/user.dart';
import 'package:flutter/material.dart';

import '../../../../core/entities/course.dart';
import '../widgets/students_list.dart';

class MultiStudentsEnrollPage extends StatefulWidget {
  /// The page route name.
  static const routeName = 'multi-students-enroll';

  const MultiStudentsEnrollPage({Key? key}) : super(key: key);

  @override
  State<MultiStudentsEnrollPage> createState() =>
      _MultiStudentsEnrollPageState();
}

class _MultiStudentsEnrollPageState extends State<MultiStudentsEnrollPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              'Nombre del curso',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          StudentsListWidget(
              listaEstudiantes: [
                User(
                    id: '64b485bd66d7f87437caaf40',
                    firstName: 'Winter',
                    lastName: 'Song',
                    identityCard: '45147258',
                    email: 'wintersong@gmail.com'),
                User(
                    id: '96369258',
                    firstName: 'Yvex',
                    lastName: 'Loona',
                    identityCard: '96369258',
                    email: 'yvexloona@gmail.com'),
                User(
                    id: '64b485f266d7f87437caaf46',
                    firstName: 'Chuu',
                    lastName: 'Loona',
                    identityCard: '74741852',
                    email: 'chuuloona@gmail.com'),
                User(
                    id: '64b4864866d7f87437caaf49',
                    firstName: 'Jin',
                    lastName: 'Soul',
                    identityCard: '78789456',
                    email: 'jinsoul@gmail.com')
              ],
              course: Course(
                  id: '64bb26ac475b585eb5f32952',
                  name: 'Modelaje',
                  description: 'Im terking on the runway',
                  teacherId: '64b1f3aaf0e763d6de7fe836')),
        ],
      ),
    );
  }
}
