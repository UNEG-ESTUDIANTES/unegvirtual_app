import 'package:flutter/material.dart';

import 'package:classroom_app/core/entities/entities.dart';
import 'package:classroom_app/features/course/presentation/widgets/units_list.dart';

class FirstPartOfRowWidget extends StatelessWidget {
  const FirstPartOfRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 30),
            CircleAvatar(
              backgroundImage: AssetImage('assets/teacher_placeholder.jpg'),
              radius: 55,
            ),
            Column(
              children: [
                _Teacher_Name(),
                SizedBox(height: 5),
                _Teacher_Number(),
                _Teacher_Mail(),
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        _Course_Name(),
        const UnitsList(
          [
            Unit(name: 'Programación Orientada a Objetos', number: 1),
          ],
        ),
      ],
    );
  }

  Container _Course_Name() {
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
              offset: Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text("Tecnicas de Programacion I",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)));
  }

  Row _Teacher_Mail() {
    return Row(
      children: [
        Icon(Icons.mail),
        SizedBox(width: 10),
        Text("ExampleEmail123@gmail.com",
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row _Teacher_Number() {
    return Row(
      children: [
        Icon(Icons.phone),
        SizedBox(width: 10),
        Text("0412-4512568",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Text _Teacher_Name() {
    return Text("Prof. Baizhu Snake",
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold));
  }
}
