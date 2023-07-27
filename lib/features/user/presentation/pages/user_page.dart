import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/providers/auth_provider.dart';
import 'package:unegvirtual_app/features/user/presentation/widgets/basic_info.dart';
import 'package:unegvirtual_app/features/user/presentation/widgets/user_data.dart';

class UserPage extends StatelessWidget {
  /// The page route name.
  static const routeName = '/user';

  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>().auth;

    if (auth == null) {
      return const Center(
        child: Text('Debe iniciar sesión para mostrar su usuario'),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: BasicInfo(user: auth.user),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            UserData(user: auth.user),
          ],
        ),
      ),
    );
  }
}
