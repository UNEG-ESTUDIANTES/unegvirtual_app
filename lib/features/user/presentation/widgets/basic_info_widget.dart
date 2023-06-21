import 'package:flutter/material.dart';

import 'package:classroom_app/features/user/presentation/widgets/score_stars.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(
            'assets/profile_xample.png',
          ),
          radius: 48,
        ),
        const SizedBox(height: 16),
        Text(
          'Xiao Yaksha',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const ScoreStars(
          score: 16,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        const SizedBox(height: 4),
        const Text(
          '2021 I - Actualidad',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {},
          child: const Text('Editar Perfil'),
        ),
      ],
    );
  }
}
