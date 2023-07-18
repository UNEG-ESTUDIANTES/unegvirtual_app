import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:classroom_app/core/providers/auth_provider.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/widgets/loading_display.dart';
import 'package:classroom_app/features/user/presentation/providers/user_provider.dart';
import 'package:classroom_app/features/user/presentation/widgets/basic_info.dart';
import 'package:classroom_app/features/user/presentation/widgets/user_data.dart';

const List<int> semesters = [1, 2, 3];

class UserPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'user';

  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final userProvider = context.watch<UserProvider>();
    final userProviderState = userProvider.state;

    if (userProviderState is Empty) {
      userProvider.getCurrentUser(authProvider.accessToken!);
    }

    if (userProviderState is Loading) return const LoadingDisplay();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: userProviderState is Error
          ? Center(
              child: Text(userProviderState.message),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicInfo(user: userProvider.user!),
                const Divider(height: 32),
                const UserData(),
              ],
            ),
    );
  }
}
