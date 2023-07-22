import 'package:classroom_app/features/course/presentation/widgets/forms/name_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const nameInput = 'Tecnicas de programacion I';
  const invalidNameInput = 'Tecnicas de programacion I!!1554.,-';

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
      // act
      final input = NameInput.dirty(nameInput);

      // assert
      expect(input.isValid, true);
    },
  );

  test(
    'should be invalid',
    () async {
      // act
      final input = NameInput.dirty(invalidNameInput);

      // assert
      expect(input.isValid, false);
    },
  );

  group('validator', () {
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
