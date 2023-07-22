import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'Debe ingresar la descripción del curso';
const tooShortMessage = 'La cedula debe tener 8 caracteres';

enum CiInputError {
  empty,
  tooShort;

  String text() {
    switch (this) {
      case CiInputError.empty:
        return emptyMessage;

      case CiInputError.tooShort:
        return tooShortMessage;
    }
  }
}

// Extend FormzInput and provide the input type and error type.
class CiInput extends FormzInput<String, CiInputError> {
  const CiInput.pure([super.value = '']) : super.pure();

  const CiInput.dirty([super.value = '']) : super.dirty();

  @override
  CiInputError? validator(String value) {
    if (value.isEmpty) return CiInputError.empty;

    return value.length < 8 ? CiInputError.tooShort : null;
  }
}
