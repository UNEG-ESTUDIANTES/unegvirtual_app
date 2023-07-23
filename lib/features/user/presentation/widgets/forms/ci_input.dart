import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'Debe ingresar su cédula';
const invalidMessage = 'Solo debe contener números';

enum CiInputError {
  empty,
  invalid;

  String text() {
    switch (this) {
      case CiInputError.empty:
        return emptyMessage;

      case CiInputError.invalid:
        return invalidMessage;
    }
  }
}

// Extend FormzInput and provide the input type and error type.
class CiInput extends FormzInput<String, CiInputError>
    with FormzInputErrorCacheMixin {
  CiInput.pure([super.value = '']) : super.pure();

  CiInput.dirty([super.value = '']) : super.dirty();

  static final _ciRegExp = RegExp(r'^[0-9]+$');

  @override
  CiInputError? validator(String value) {
    if (value.isEmpty) return CiInputError.empty;

    return _ciRegExp.hasMatch(value) ? null : CiInputError.invalid;
  }
}
