import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:provider/provider.dart';

import 'package:classroom_app/core/pages/main_page.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';
import 'package:classroom_app/features/auth/presentation/pages/forgot_page.dart';
import 'package:classroom_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:classroom_app/features/auth/presentation/widgets/forms/email_input.dart';
import 'package:classroom_app/features/auth/presentation/widgets/forms/login_form_state.dart';
import 'package:classroom_app/features/auth/presentation/widgets/forms/password_input.dart';

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

    SnackBar snackBar;
    final authProviderState = context.read<AuthProvider>().state;

    if (authProviderState is Error) {
      snackBar = SnackBar(content: Text(authProviderState.message));
    } else {
      snackBar = const SnackBar(content: Text('Ha iniciado sesión con éxito'));
    }

    // Display the snackbar.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    // Navigates to main page.
    if (authProviderState is Loaded) {
      _resetForm();
      Navigator.pushReplacementNamed(context, MainPage.routeName);
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
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _key,
      child: Column(
        children: [
          const Image(
            image: AssetImage(
              'assets/uneg_logo_color.png',
            ),
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          Text(
            'Accede al Aula',
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Si eres estudiante regular de la UNEG, ingresa con tu cédula de identidad',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'ej: johndoe@gmail.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text('Correo Electrónico'),
            ),
            validator: (_) => _state.email.displayError?.text(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                validator: (_) => _state.password.displayError?.text(),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ForgotPasswordPage.routeName);
                },
                child: const Text('Olvide mi contraseña'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_state.status.isInProgress)
            const CircularProgressIndicator()
          else
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
          // const SizedBox(height: 8),
          // SizedBox(
          //   width: double.infinity,
          //   child: FilledButton.tonal(
          //     onPressed: () {},
          //     child: const Padding(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 16.0,
          //         vertical: 12.0,
          //       ),
          //       child: Text(
          //         'Iniciar Sesión como Invitado',
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
