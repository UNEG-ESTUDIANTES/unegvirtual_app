import 'package:flutter/material.dart';

class SemesterSelectWidget extends StatelessWidget {
  const SemesterSelectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (() {}),
      style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          fixedSize: Size(170, 60)),
      child: Text("Semestre 1",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }
}
