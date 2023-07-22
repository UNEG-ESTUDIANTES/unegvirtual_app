import 'package:classroom_app/core/entities/user.dart';
import 'package:flutter/material.dart';

class SelectedStudentsRowWIdget extends StatefulWidget {
  const SelectedStudentsRowWIdget({
    super.key,
    required List<User> alumnosSeleccionados,
  }) : _alumnosSeleccionados = alumnosSeleccionados;

  final List<User> _alumnosSeleccionados;

  @override
  State<SelectedStudentsRowWIdget> createState() =>
      _SelectedStudentsRowWIdgetState();
}

class _SelectedStudentsRowWIdgetState extends State<SelectedStudentsRowWIdget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget._alumnosSeleccionados
          .map((alumno) => Text(
              '${alumno.identityCard} | ${alumno.firstName} ${alumno.lastName} | ${alumno.email}'))
          .toList(),
    );
  }
}
