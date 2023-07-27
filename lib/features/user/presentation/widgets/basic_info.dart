import 'package:flutter/material.dart';

import 'package:unegvirtual_app/core/entities/user.dart';

class BasicInfo extends StatelessWidget {
  final User user;

  const BasicInfo({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              const CircleAvatar(
                radius: 48,
              ),
              const SizedBox(width: 24),
              _UserDescription(user: user),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 48,
            ),
            const SizedBox(height: 16),
            _UserDescription(
              user: user,
              crossAxisAlignment: CrossAxisAlignment.center,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}

class _UserDescription extends StatelessWidget {
  final User user;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextAlign? textAlign;

  const _UserDescription(
      {this.crossAxisAlignment, required this.user, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          '${user.firstName} ${user.lastName}',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: textAlign ?? TextAlign.start,
        ),
        const SizedBox(height: 4),
        Text(user.email),
      ],
    );
  }
}
