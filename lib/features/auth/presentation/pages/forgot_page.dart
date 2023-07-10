import 'package:flutter/material.dart';

import '../widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  /// The page route name.
  static const routeName = 'forgotpassword';

  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
      ),
      backgroundColor: Colors.grey.shade100,
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: SizedBox(
            width: 400,
            child: Card(
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: ForgotPasswordForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
