import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'Debe ingresar la descripción del curso';
const tooShortMessage = 'Debe tener al menos 4 caracteres';

enum DescriptionInputError {
  empty,
  tooShort;

  String text() {
    switch (this) {
      case DescriptionInputError.empty:
        return emptyMessage;

      case DescriptionInputError.tooShort:
        return tooShortMessage;
    }
  }
}

// Extend FormzInput and provide the input type and error type.
class DescriptionInput extends FormzInput<String, DescriptionInputError> {
  const DescriptionInput.pure([super.value = '']) : super.pure();

  const DescriptionInput.dirty([super.value = '']) : super.dirty();

  @override
  DescriptionInputError? validator(String value) {
    if (value.isEmpty) return DescriptionInputError.empty;

    return value.length < 4 ? DescriptionInputError.tooShort : null;
  }
}
