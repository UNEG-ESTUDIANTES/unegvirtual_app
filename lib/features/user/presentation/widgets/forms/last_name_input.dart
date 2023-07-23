import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'Debe ingresar su apellido';

enum LastNameInputError {
  empty;

  String text() {
    switch (this) {
      case LastNameInputError.empty:
        return emptyMessage;
    }
  }
}

// Extend FormzInput and provide the input type and error type.
class LastNameInput extends FormzInput<String, LastNameInputError> {
  const LastNameInput.pure([super.value = '']) : super.pure();

  const LastNameInput.dirty([super.value = '']) : super.dirty();

  @override
  LastNameInputError? validator(String value) {
    return value.isEmpty ? LastNameInputError.empty : null;
  }
}
