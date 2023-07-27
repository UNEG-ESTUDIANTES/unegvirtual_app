import 'package:flutter_test/flutter_test.dart';

import 'package:unegvirtual_app/core/forms/email_input.dart';

void main() {
  const tValidEmail = 'test@gmail.com';
  const tInvalidEmail = 'test';

  test(
    'initial state should be empty',
    () async {
      // act
      final input = EmailInput.pure();

      // assert
      expect(input.value, '');
      expect(input.displayError, null);
    },
  );

  test(
    'should be valid',
    () async {
      // act
      final input = EmailInput.dirty(tValidEmail);

      // assert
      expect(input.isValid, true);
    },
  );

  test(
    'should be invalid',
    () async {
      // act
      final input = EmailInput.dirty(tInvalidEmail);

      // assert
      expect(input.isValid, false);
    },
  );

  group('validator', () {
    test(
      'should return empty error',
      () async {
        // act
        final input = EmailInput.dirty();

        // assert
        expect(input.displayError, EmailInputError.empty);
        expect(input.displayError?.text(), emptyMessage);
      },
    );

    test(
      'should return invalid error',
      () async {
        // act
        final input = EmailInput.dirty(tInvalidEmail);

        // assert
        expect(input.displayError, EmailInputError.invalid);
        expect(input.displayError?.text(), invalidMessage);
      },
    );
  });
}
