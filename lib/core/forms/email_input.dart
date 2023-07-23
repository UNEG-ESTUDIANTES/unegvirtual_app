import 'package:formz/formz.dart';

const emptyMessage = 'Debe ingresar su correo electrónico';
const invalidMessage = 'Debe ingresar un correo electrónico valido';

enum EmailInputError {
  empty,
  invalid;

  String text() {
    switch (this) {
      case EmailInputError.empty:
        return emptyMessage;

      case EmailInputError.invalid:
        return invalidMessage;
    }
  }
}

class EmailInput extends FormzInput<String, EmailInputError>
    with FormzInputErrorCacheMixin {
  EmailInput.pure([super.value = '']) : super.pure();

  EmailInput.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) return EmailInputError.empty;

    return _emailRegExp.hasMatch(value) ? null : EmailInputError.invalid;
  }
}
