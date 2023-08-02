import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/forms/email_input.dart';
import 'package:unegvirtual_app/core/forms/password_input.dart';
import 'package:unegvirtual_app/core/providers/auth_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/services/notifications_service.dart';
import 'package:unegvirtual_app/features/auth/domain/entities/user_credentials.dart';
import 'package:unegvirtual_app/features/auth/presentation/pages/forgot_page.dart';
import 'package:unegvirtual_app/features/auth/presentation/widgets/forms/login_form_state.dart';
import 'package:unegvirtual_app/features/home/presentation/pages/home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _key = GlobalKey<FormState>();
  late LoginFormState _state;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  void _onEmailChanged() {
    setState(() {
      _state = _state.copyWith(email: EmailInput.dirty(_emailController.text));
    });
  }

  void _onPasswordChanged() {
    setState(() {
      _state = _state.copyWith(
        password: PasswordInput.dirty(_passwordController.text),
      );
    });
  }

  void _resetForm() {
    _key.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();

    setState(() => _state = LoginFormState());
  }

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    setState(() {
      _state = _state.copyWith(status: FormzSubmissionStatus.inProgress);
    });

    // Try to login the user.
    await context.read<AuthProvider>().login(
          UserCredentials(
            email: _state.email.value,
            password: _state.password.value,
          ),
        );

    if (!mounted) return;

    final authProvider = context.read<AuthProvider>();
    final authProviderState = authProvider.state;
    String snackBarMessage;

    // Change state and snackbar according to state.
    if (authProviderState is Error) {
      _state = _state.copyWith(status: FormzSubmissionStatus.failure);
      snackBarMessage = authProviderState.message;
    } else {
      _state = _state.copyWith(status: FormzSubmissionStatus.success);
      snackBarMessage = 'Ha iniciado sesión con éxito';
    }

    setState(() {});

    if (!mounted) return;

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    // Display the snackbar.
    NotificationsService.showSnackBar(snackBarMessage);

    // Navigates to main page.
    if (_state.status.isSuccess) {
      _resetForm();

      context.go(HomePage.routeName);
    }
  }

  @override
  void initState() {
    super.initState();

    _state = LoginFormState();

    _emailController = TextEditingController(
      text: _state.email.value,
    )..addListener(_onEmailChanged);

    _passwordController = TextEditingController(
      text: _state.password.value,
    )..addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'ej: johndoe@gmail.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text('Correo Electrónico'),
            ),
            validator: (_) => _state.email.error?.text(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'ej: 1234',
                  label: const Text('Contraseña'),
                ),
                validator: (_) => _state.password.error?.text(),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.push(ForgotPasswordPage.routeName),
                child: const Text('Olvide mi contraseña'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          if (_state.status.isInProgress)
            const CircularProgressIndicator()
          else
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _onSubmit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      child: Text(
                        'Iniciar Sesión',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
