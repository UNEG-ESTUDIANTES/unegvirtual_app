import 'package:flutter/material.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/teacher_placeholder.jpg'),
          radius: 55,
        ),
        _TeacherInfo(),
      ],
    );
  }
}

class _TeacherInfo extends StatelessWidget {
  const _TeacherInfo();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'Prof. Nombre Apellido',
          style: textTheme.titleLarge,
        ),
        const _TeacherInfoItem(
          value: 'Número de Telefono',
          icon: Icons.phone,
        ),
        const _TeacherInfoItem(
          value: 'Correo Electrónico',
          icon: Icons.email,
        ),
      ],
    );
  }
}

class _TeacherInfoItem extends StatelessWidget {
  final String value;
  final IconData icon;

  const _TeacherInfoItem({
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(value),
      ],
    );
  }
}