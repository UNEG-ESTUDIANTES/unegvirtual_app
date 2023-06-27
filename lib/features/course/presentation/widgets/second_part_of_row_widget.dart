import 'package:flutter/material.dart';

class SecondPartOfRowWidget extends StatelessWidget {
  const SecondPartOfRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/teacher_placeholder.jpg'),
          radius: 55,
        ),
        SizedBox(height: 10),
        Text("Prof. Baizhu Snake",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold))
      ],
    );
  }
}
