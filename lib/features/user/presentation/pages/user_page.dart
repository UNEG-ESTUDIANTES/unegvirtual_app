import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:classroom_app/core/providers/auth_provider.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/widgets/loading_display.dart';
import 'package:classroom_app/features/user/presentation/providers/user_provider.dart';
import 'package:classroom_app/features/user/presentation/widgets/basic_info.dart';
import 'package:classroom_app/features/user/presentation/widgets/user_data.dart';

class UserPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'user';

  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final userProvider = context.watch<UserProvider>();
    final userProviderState = userProvider.state;

    if (authProvider.accessToken == null) {
      return const Center(
        child: Text('Debe iniciar sesión para mostrar su usuario'),
      );
    }

    if (userProviderState is Empty) {
      userProvider.getCurrentUser(authProvider.accessToken!);
    }

    if (userProviderState is Loading) return const LoadingDisplay();

    if (userProviderState is Error) {
      return Center(
        child: Text(userProviderState.message),
      );
    }

    if (userProvider.user == null) {
      return const Center(
        child: Text('No hay usuario por mostrar'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: BasicInfo(user: userProvider.user!),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          UserData(user: userProvider.user!),
        ],
      ),
    );
  }
}
