import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/features/auth/presentation/widgets/forms/password_input.dart';

void main() {
  const tValidPassword = 'test';
  const tInvalidPassword = '';

  test(
    'initial state should be empty',
    () async {
      // act
      final input = PasswordInput.pure();

      // assert
      expect(input.value, '');
      expect(input.displayError, null);
    },
  );

  test(
    'should be valid',
    () async {
      // act
      final input = PasswordInput.dirty(tValidPassword);

      // assert
      expect(input.isValid, true);
    },
  );

  test(
    'should be invalid',
    () async {
      // act
      final input = PasswordInput.dirty(tInvalidPassword);

      // assert
      expect(input.isValid, false);
    },
  );

  group('validator', () {
    test(
      'should return empty error',
      () async {
        // act
        final input = PasswordInput.dirty();

        // assert
        expect(input.displayError, PasswordInputError.empty);
        expect(input.displayError?.text(), emptyMessage);
      },
    );
  });
}
