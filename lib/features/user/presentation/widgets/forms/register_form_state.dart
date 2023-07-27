import 'package:formz/formz.dart';

import 'package:unegvirtual_app/core/forms/email_input.dart';
import 'package:unegvirtual_app/features/user/presentation/widgets/forms/first_name_input.dart';
import 'package:unegvirtual_app/features/user/presentation/widgets/forms/last_name_input.dart';

import '../../../../../core/forms/password_input.dart';

import 'ci_input.dart';

class RegisterFormState with FormzMixin {
  final EmailInput email;
  final FirstNameInput firstName;
  final LastNameInput lastName;
  final PasswordInput password;
  final CiInput ci;

  final FormzSubmissionStatus status;

  RegisterFormState({
    EmailInput? email,
    CiInput? ci,
    this.firstName = const FirstNameInput.pure(),
    this.lastName = const LastNameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
  })  : email = email ?? EmailInput.pure(),
        ci = ci ?? CiInput.pure();

  RegisterFormState copyWith({
    EmailInput? email,
    FirstNameInput? firstName,
    LastNameInput? lastName,
    CiInput? ci,
    PasswordInput? password,
    FormzSubmissionStatus? status,
  }) {
    return RegisterFormState(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      ci: ci ?? this.ci,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput> get inputs => [email, password, firstName, lastName, ci];
}
