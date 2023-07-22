import 'package:classroom_app/core/forms/name_input.dart';
import 'package:classroom_app/features/user/presentation/widgets/forms/register_form_state.dart';
import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:provider/provider.dart';

import '../../../../core/forms/email_input.dart';
import '../../../../core/forms/password_input.dart';
import '../../../../core/pages/main_page.dart';
import '../widgets/forms/ci_input.dart';
import '../widgets/forms/type_input.dart';

class RegisterPage extends StatefulWidget {
  /// The page route name.
  static const routeName = 'register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<FormState>();
  late RegisterFormState _state;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _ciController;
  late final TextEditingController _typeController;

  void _onEmailChanged() {
    setState(() {
      _state = _state.copyWith(email: EmailInput.dirty(_emailController.text));
    });
  }

  void _onFirstNameChanged() {
    setState(() {
      _state =
          _state.copyWith(firtsName: NameInput.dirty(_emailController.text));
    });
  }

  void _onLastNameChanged() {
    setState(() {
      _state =
          _state.copyWith(lastName: NameInput.dirty(_emailController.text));
    });
  }

  void _onCiChanged() {
    setState(() {
      _state = _state.copyWith(ci: CiInput.dirty(_emailController.text));
    });
  }

  void _onTypeChanged() {
    setState(() {
      _state = _state.copyWith(type: TypeInput.dirty(_emailController.text));
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
    _firstNameController.clear();
    _lastNameController.clear();
    _typeController.clear();
    _ciController.clear();

    setState(() => _state = RegisterFormState());
  }

  /// Removes previous pages and go to main page.
  void _navigateToMainPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainPage.routeName,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();

    _state = RegisterFormState();

    _emailController = TextEditingController(
      text: _state.email.value,
    )..addListener(_onEmailChanged);

    _passwordController = TextEditingController(
      text: _state.password.value,
    )..addListener(_onPasswordChanged);

    _firstNameController = TextEditingController(
      text: _state.firtsName.value,
    )..addListener(_onFirstNameChanged);

    _lastNameController = TextEditingController(
      text: _state.lastName.value,
    )..addListener(_onLastNameChanged);

    _ciController = TextEditingController(
      text: _state.lastName.value,
    )..addListener(_onCiChanged);

    _typeController = TextEditingController(
      text: _state.lastName.value,
    )..addListener(_onTypeChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ciController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  String _selectedRole = 'STUDENT';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Usuario'),
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
                children: [
                  SizedBox(
                    width: 450,
                    child: Card(
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 32.0,
                        ),
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Crear Usuario',
                                style: textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 8),
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
                                validator: (_) => _state.email.error?.text(),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  hintText: 'Roberto',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: const Text('Nombre'),
                                ),
                                validator: (_) =>
                                    _state.firtsName.error?.text(),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  hintText: 'Rojas',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: const Text('Apellido'),
                                ),
                                validator: (_) => _state.lastName.error?.text(),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _ciController,
                                decoration: InputDecoration(
                                  hintText: '12123123',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: const Text('Cedula de identidad'),
                                ),
                                validator: (_) => _state.ci.error?.text(),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 16),
                              DropdownButton(
                                value: _selectedRole,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                underline: Container(
                                  height: 2,
                                  color: Colors.blueAccent,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedRole = newValue!;
                                  });
                                  _onTypeChanged();
                                },
                                items: <String>['STUDENT', 'TEACHER', 'ADMIN']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
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
                                    validator: (_) =>
                                        _state.password.error?.text(),
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                              const SizedBox(height: 24),
                              if (_state.status.isInProgress)
                                const CircularProgressIndicator()
                              else
                                Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: FilledButton(
                                        onPressed: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 24.0,
                                            vertical: 12.0,
                                          ),
                                          child: Text(
                                            'Crear Usuario',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
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
