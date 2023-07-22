import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'Debe ingresar el nombre del curso';
const tooShortMessage = 'Debe tener al menos 4 caracteres';
const invalidMessage =
    'Debe comenzar con un letra y no contener caracteres especiales';

enum NameInputError {
  empty,
  tooShort,
  invalid;

  String text() {
    switch (this) {
      case NameInputError.empty:
        return emptyMessage;

      case NameInputError.tooShort:
        return tooShortMessage;

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

    if (value.length < 4) return NameInputError.tooShort;

    return _stringRegExp.hasMatch(value) ? null : NameInputError.invalid;
  }
}
