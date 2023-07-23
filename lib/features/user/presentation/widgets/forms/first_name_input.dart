import 'package:formz/formz.dart';

// Define input validation errors
const emptyMessage = 'Debe ingresar su nombre';

enum FirstNameInputError {
  empty;

  String text() {
    switch (this) {
      case FirstNameInputError.empty:
        return emptyMessage;
    }
  }
}

// Extend FormzInput and provide the input type and error type.
class FirstNameInput extends FormzInput<String, FirstNameInputError> {
  const FirstNameInput.pure([super.value = '']) : super.pure();

  const FirstNameInput.dirty([super.value = '']) : super.dirty();

  @override
  FirstNameInputError? validator(String value) {
    return value.isEmpty ? FirstNameInputError.empty : null;
  }
}
