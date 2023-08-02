import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  /// The page route name.
  static const routeName = '/forgot-password';

  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight - kToolbarHeight,
                minWidth: double.infinity,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: getValueForScreenType(
                  context: context,
                  mobile: MainAxisAlignment.start,
                  tablet: MainAxisAlignment.center,
                ),
                children: const [
                  SizedBox(
                    width: 450,
                    child: _ForgotBody(),
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

class _ForgotBody extends StatelessWidget {
  const _ForgotBody();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Olvidé mi Contraseña',
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: 24),
        Text(
          'Recibirá en su correo electrónico instrucciones para el reestablecimiento de su contraseña.',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        const ForgotPasswordForm(),
      ],
    );
  }
}
