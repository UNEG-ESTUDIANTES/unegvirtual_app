import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'Debe seleccionar el tipo de usuario';

enum TypeInputError {
  empty;

  String text() {
    switch (this) {
      case TypeInputError.empty:
        return emptyMessage;
    }
  }
}

// Extend FormzInput and provide the input type and error type.
class TypeInput extends FormzInput<String, TypeInputError> {
  const TypeInput.pure([super.value = '']) : super.pure();

  const TypeInput.dirty([super.value = '']) : super.dirty();

  @override
  TypeInputError? validator(String value) {
    return value.isEmpty ? TypeInputError.empty : null;
  }
}
