import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:unegvirtual_app/core/providers/auth_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/providers/user_provider.dart';
import 'package:unegvirtual_app/core/services/notifications_service.dart';
import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart';
import 'package:unegvirtual_app/features/user/presentation/widgets/forms/first_name_input.dart';
import 'package:unegvirtual_app/features/user/presentation/widgets/forms/last_name_input.dart';
import 'package:unegvirtual_app/features/user/presentation/widgets/forms/register_form_state.dart';

import '../../../../core/forms/email_input.dart';
import '../../../../core/forms/password_input.dart';
import '../widgets/forms/ci_input.dart';

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

  void _onEmailChanged() {
    setState(() {
      _state = _state.copyWith(email: EmailInput.dirty(_emailController.text));
    });
  }

  void _onFirstNameChanged() {
    setState(() {
      _state = _state.copyWith(
          firstName: FirstNameInput.dirty(_firstNameController.text));
    });
  }

  void _onLastNameChanged() {
    setState(() {
      _state = _state.copyWith(
          lastName: LastNameInput.dirty(_lastNameController.text));
    });
  }

  void _onCiChanged() {
    setState(() {
      _state = _state.copyWith(ci: CiInput.dirty(_ciController.text));
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
    _ciController.clear();

    setState(() => _state = RegisterFormState());
  }

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    final auth = context.read<AuthProvider>().auth;

    if (auth == null) {
      NotificationsService.showSnackBar(
        'Debe estar autenticado para realizar esta acción',
      );

      return;
    }

    setState(() {
      _state = _state.copyWith(status: FormzSubmissionStatus.inProgress);
    });

    // Try to create user.
    await context.read<UserProvider>().createUser(
          accessToken: auth.accessToken,
          unsavedUser: UnsavedUser(
            firstName: _state.firstName.value,
            lastName: _state.lastName.value,
            identityCard: _state.ci.value,
            email: _state.email.value,
            password: _state.password.value,
            securityKey: _state.password.value,
            type: _selectedRole,
          ),
        );

    if (!mounted) return;

    final userProvider = context.read<UserProvider>();
    final userProviderState = userProvider.state;
    String snackBarMessage;

    // Change state and snackbar according to state.
    if (userProviderState is Error) {
      _state = _state.copyWith(status: FormzSubmissionStatus.failure);
      snackBarMessage = userProviderState.message;
    } else {
      _state = _state.copyWith(status: FormzSubmissionStatus.success);
      snackBarMessage = 'Ha creado el usuario con éxito';
    }

    setState(() {});

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    // Display the snackbar.
    NotificationsService.showSnackBar(snackBarMessage);

    // Navigates to users page.
    if (_state.status.isSuccess) {
      _resetForm();
      context.pop();
    }
  }

  void onRoleChange(String? value) {
    if (value == null) return;

    setState(() {
      _selectedRole = value;
    });
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
      text: _state.firstName.value,
    )..addListener(_onFirstNameChanged);

    _lastNameController = TextEditingController(
      text: _state.lastName.value,
    )..addListener(_onLastNameChanged);

    _ciController = TextEditingController(
      text: _state.ci.value,
    )..addListener(_onCiChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ciController.dispose();
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
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _key,
              child: Center(
                child: SizedBox(
                  width: 450,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: 'John',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          label: const Text('Nombre'),
                        ),
                        validator: (_) => _state.firstName.error?.text(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          hintText: 'Doe',
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
                        controller: _ciController,
                        decoration: InputDecoration(
                          hintText: '10000000',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          label: const Text('Cédula de Identidad'),
                        ),
                        validator: (_) => _state.ci.error?.text(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      Text(
                        'Tipo de Usuario',
                        style: textTheme.titleSmall,
                      ),
                      _RoleTile(
                        title: 'Administrador',
                        value: 'ADMIN',
                        onChanged: onRoleChange,
                        groupValue: _selectedRole,
                      ),
                      _RoleTile(
                        title: 'Docente',
                        value: 'TEACHER',
                        onChanged: onRoleChange,
                        groupValue: _selectedRole,
                      ),
                      _RoleTile(
                        title: 'Estudiante',
                        value: 'STUDENT',
                        onChanged: onRoleChange,
                        groupValue: _selectedRole,
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
                                onPressed: _onSubmit,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 12.0,
                                  ),
                                  child: Text(
                                    'Crear',
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
          );
        },
      ),
    );
  }
}

class _RoleTile extends StatelessWidget {
  final String title;
  final String value;
  final void Function(String?) onChanged;
  final String? groupValue;

  const _RoleTile({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        leading: Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
