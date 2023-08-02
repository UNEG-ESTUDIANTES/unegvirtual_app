import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:unegvirtual_app/features/auth/presentation/widgets/login_form.dart';

class LogInPage extends StatelessWidget {
  /// The page route name.
  static const routeName = '/login';

  const LogInPage({super.key});

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
                    child: _LoginBody(),
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

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inicio de Sesión',
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: 24),
        Text(
          'Si eres estudiante regular de la UNEG, ingresa con tu cédula de identidad.',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        const LoginForm(),
      ],
    );
  }
}
