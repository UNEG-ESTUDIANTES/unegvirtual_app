import 'package:classroom_app/features/user/presentation/widgets/forms/type_input.dart';
import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:provider/provider.dart';

import 'package:classroom_app/core/forms/email_input.dart';

import '../../../../../core/forms/name_input.dart';
import '../../../../../core/forms/password_input.dart';
import 'ci_input.dart';

class RegisterFormState with FormzMixin {
  final EmailInput email;
  final NameInput firtsName;
  final NameInput lastName;
  final PasswordInput password;
  final CiInput ci;
  final TypeInput type;

  final FormzSubmissionStatus status;

  RegisterFormState({
    EmailInput? email,
    NameInput? firtsName,
    NameInput? lastName,
    CiInput? ci,
    TypeInput? type,
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
  })  : email = email ?? EmailInput.pure(),
        firtsName = firtsName ?? NameInput.pure(),
        lastName = lastName ?? NameInput.pure(),
        ci = ci ?? CiInput.pure(),
        type = type ?? TypeInput.pure();

  RegisterFormState copyWith({
    EmailInput? email,
    NameInput? firtsName,
    NameInput? lastName,
    CiInput? ci,
    TypeInput? type,
    PasswordInput? password,
    FormzSubmissionStatus? status,
  }) {
    return RegisterFormState(
      email: email ?? this.email,
      firtsName: firtsName ?? this.firtsName,
      lastName: lastName ?? this.lastName,
      ci: ci ?? this.ci,
      type: type ?? this.type,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput> get inputs =>
      [email, password, firtsName, lastName, ci, type];
}
