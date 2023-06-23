import 'package:flutter/material.dart';

import 'package:classroom_app/features/user/presentation/widgets/score_stars.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/profile_xample.png',
                ),
                radius: 80,
              ),
              SizedBox(width: 24),
              _UserDescription(),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/profile_xample.png',
              ),
              radius: 48,
            ),
            SizedBox(height: 16),
            _UserDescription(
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ],
        );
      },
    );
  }
}

class _UserDescription extends StatelessWidget {
  final CrossAxisAlignment? crossAxisAlignment;

  const _UserDescription({this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
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
