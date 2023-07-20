import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'La informacion ingresada debe ser de 4 o mas caracteres';
const invalidMessage =
    'La informacion ingresada no debe tener caracteres epeciales';

enum NameInputError {
  empty,
  invalid;

  String text() {
    switch (this) {
      case NameInputError.empty:
        return emptyMessage;

      case NameInputError.invalid:
        return invalidMessage;
    }
  }
}

// Extend FormzInput and provide the input type and error type.
class NameInput extends FormzInput<String, NameInputError>
    with FormzInputErrorCacheMixin {
  NameInput.pure([super.value = '']) : super.pure();

  NameInput.dirty([super.value = '']) : super.dirty();

  static final _stringRegExp = RegExp(r'^[A-Za-z]+(\s[A-Za-z0-9]+)*$');

  @override
  NameInputError? validator(String value) {
    if (value.isEmpty) return NameInputError.empty;

    return _stringRegExp.hasMatch(value) ? null : NameInputError.invalid;
  }
}
