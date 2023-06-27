import 'package:flutter/material.dart';

class NotesTableStartWidget extends StatelessWidget {
  const NotesTableStartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 50),
        Text("Materia",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start),
        Expanded(child: SizedBox(width: 1)),
        Text("Nota",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start),
        SizedBox(width: 20),
      ],
    );
  }
}
