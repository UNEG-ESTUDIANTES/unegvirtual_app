import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'users';

  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Usuarios',
            style: textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
