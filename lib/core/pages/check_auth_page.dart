import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:classroom_app/core/pages/main_page.dart';
import 'package:classroom_app/core/providers/auth_provider.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/providers/user_provider.dart';
import 'package:classroom_app/features/landing/presentation/pages/landing_page.dart';

class CheckAuthPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'check-auth';

  const CheckAuthPage({super.key});

  /// Removes previous pages and go to main page.
  Future _navigateTo(BuildContext context, String routeName) {
    return Navigator.popAndPushNamed(
      context,
      routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final authProviderState = authProvider.state;

    final userProvider = context.watch<UserProvider>();
    final userProviderState = userProvider.state;

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: context.read<AuthProvider>().getToken(),
          builder: (context, _) {
            if (authProviderState is Loading) {
              return const CircularProgressIndicator();
            }

            // Try to get the user.
            if (authProviderState is Loaded) {
              return FutureBuilder(
                future: context.read<UserProvider>().getCurrentUser(
                      authProvider.accessToken!,
                    ),
                builder: (context, _) {
                  if (userProviderState is Loading) {
                    return const CircularProgressIndicator();
                  }

                  // Redirect to main page.
                  if (userProviderState is Loaded) {
                    Future.microtask(
                      () => _navigateTo(context, MainPage.routeName),
                    );
                  }

                  // Redirect to landing.
                  if (userProviderState is Error) {
                    Future.microtask(
                      () => _navigateTo(context, LandingPage.routeName),
                    );
                  }

                  return Container();
                },
              );
            }

            // Redirect to landing.
            if (authProviderState is Error) {
              Future.microtask(
                () => _navigateTo(context, LandingPage.routeName),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
