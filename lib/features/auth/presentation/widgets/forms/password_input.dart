import 'package:formz/formz.dart';

const emptyMessage = 'Debe ingresar su contraseña';

enum PasswordInputError {
  empty;

  String text() {
    switch (this) {
      case PasswordInputError.empty:
        return emptyMessage;
    }
  }
}

class PasswordInput extends FormzInput<String, PasswordInputError>
    with FormzInputErrorCacheMixin {
  PasswordInput.pure() : super.pure('');

  PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordInputError? validator(String value) {
    return value.isEmpty ? PasswordInputError.empty : null;
  }
}
