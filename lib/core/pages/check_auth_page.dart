import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:classroom_app/core/pages/main_page.dart';
import 'package:classroom_app/core/providers/auth_provider.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/features/landing/presentation/pages/landing_page.dart';

class CheckAuthPage extends StatelessWidget {
  /// The page route name.
  static const routeName = '/check-auth';

  const CheckAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final authProviderState = authProvider.state;

    if (authProviderState is Empty) authProvider.getAuth();

    if (authProviderState is Error) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          context.pushReplacement(LandingPage.routeName);
        },
      );
    }

    if (authProviderState is Loaded) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          context.pushReplacement(MainPage.routeName);
        },
      );
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
