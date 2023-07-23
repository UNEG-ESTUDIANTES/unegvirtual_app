import 'package:formz/formz.dart';

import 'package:classroom_app/core/forms/email_input.dart';
import 'package:classroom_app/core/forms/password_input.dart';

class LoginFormState with FormzMixin {
  final EmailInput email;
  final PasswordInput password;
  final FormzSubmissionStatus status;

  LoginFormState({
    EmailInput? email,
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
  }) : email = email ?? EmailInput.pure();

  LoginFormState copyWith({
    EmailInput? email,
    PasswordInput? password,
    FormzSubmissionStatus? status,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput> get inputs => [email, password];
}
