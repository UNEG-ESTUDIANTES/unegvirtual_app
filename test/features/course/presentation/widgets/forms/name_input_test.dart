import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/features/course/presentation/widgets/forms/name_input.dart';

void main() {
  test(
    'initial state should be empty',
    () async {
      // act
      final input = NameInput.pure();

      // assert
      expect(input.value, '');
      expect(input.displayError, null);
    },
  );

  test(
    'should be valid',
    () async {
      // arrange
      const names = [
        'course',
        'course 1',
        'course I',
        'tecnicas de programacion I',
      ];

      for (final name in names) {
        // act
        final input = NameInput.dirty(name);

        // assert
        expect(input.isValid, true);
      }
    },
  );

  test(
    'should be invalid',
    () async {
      // arrange
      const names = [
        '1course',
        'course1',
        '',
        '   ',
        '*',
      ];

      for (final name in names) {
        // act
        final input = NameInput.dirty(name);

        // assert
        expect(input.isValid, false);
      }
    },
  );

  group('validator', () {
    const invalidNameInput = 'Test - Test';

    test(
      'should return empty error',
      () async {
        // act
        final input = NameInput.dirty();

        // assert
        expect(input.displayError, NameInputError.empty);
        expect(input.displayError?.text(), emptyMessage);
      },
    );

    test(
      'should return invalid error',
      () async {
        // act
        final input = NameInput.dirty(invalidNameInput);

        // assert
        expect(input.displayError, NameInputError.invalid);
        expect(input.displayError?.text(), invalidMessage);
      },
    );
  });
}
