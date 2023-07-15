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
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                minWidth: double.infinity,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
