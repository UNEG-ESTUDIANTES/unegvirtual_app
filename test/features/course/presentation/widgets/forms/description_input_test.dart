import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/features/course/presentation/widgets/forms/description_input.dart';

void main() {
  test(
    'initial state should be empty',
    () async {
      // act
      const input = DescriptionInput.pure();

      // assert
      expect(input.value, '');
      expect(input.displayError, null);
    },
  );

  test(
    'should be valid',
    () async {
      // act
      const input = DescriptionInput.dirty('my description');

      // assert
      expect(input.isValid, true);
    },
  );

  test(
    'should be invalid',
    () async {
      // arrange
      const names = [
        'tes',
        '',
      ];

      for (final name in names) {
        // act
        final input = DescriptionInput.dirty(name);

        // assert
        expect(input.isValid, false);
      }
    },
  );

  group('validator', () {
    test(
      'should return empty error',
      () async {
        // act
        const input = DescriptionInput.dirty();

        // assert
        expect(input.displayError, DescriptionInputError.empty);
        expect(input.displayError?.text(), emptyMessage);
      },
    );

    test(
      'should return tooShort error',
      () async {
        // act
        const input = DescriptionInput.dirty('tes');

        // assert
        expect(input.displayError, DescriptionInputError.tooShort);
        expect(input.displayError?.text(), tooShortMessage);
      },
    );
  });
}
