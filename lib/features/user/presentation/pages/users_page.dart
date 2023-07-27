import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:unegvirtual_app/features/user/presentation/pages/register_page.dart';

class UsersPage extends StatelessWidget {
  /// The page route name.
  static const routeName = '/users';

  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('$routeName/${RegisterPage.routeName}'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
