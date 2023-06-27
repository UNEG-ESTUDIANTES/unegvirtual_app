import 'package:flutter/material.dart';

import 'package:classroom_app/core/entities/entities.dart';
import 'package:classroom_app/features/course/presentation/widgets/teacher_card.dart';
import 'package:classroom_app/features/course/presentation/widgets/units_list.dart';

class FirstPartOfRowWidget extends StatelessWidget {
  const FirstPartOfRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TeacherCard(),
        SizedBox(height: 10),
        _TitleWrapper('Técnicas de Programación I'),
        UnitsList(
          [
            Unit(
              name: 'Programación Orientada a Objetos',
              number: 1,
            ),
          ],
        ),
      ],
    );
  }
}

class _TitleWrapper extends StatelessWidget {
  final String title;

  const _TitleWrapper(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            blurRadius: 20.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        "Tecnicas de Programacion I",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
