import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'Debe ingresar la descripción del curso';
const tooShortMessage = 'Debe tener al menos 4 caracteres';

enum TypeInputError {
  empty,
  tooShort;

  String text() {
    switch (this) {
      case TypeInputError.empty:
        return emptyMessage;

      case TypeInputError.tooShort:
        return tooShortMessage;
    }
  }
}

// Extend FormzInput and provide the input type and error type.
class TypeInput extends FormzInput<String, TypeInputError> {
  const TypeInput.pure([super.value = '']) : super.pure();

  const TypeInput.dirty([super.value = '']) : super.dirty();

  @override
  TypeInputError? validator(String value) {
    if (value.isEmpty) return TypeInputError.empty;

    return value.length < 4 ? TypeInputError.tooShort : null;
  }
}
