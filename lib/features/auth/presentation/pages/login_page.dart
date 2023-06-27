import 'package:flutter/material.dart';

import 'package:classroom_app/features/auth/presentation/widgets/login_form.dart';

class LogInPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'login';

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Card(
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: LoginForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
