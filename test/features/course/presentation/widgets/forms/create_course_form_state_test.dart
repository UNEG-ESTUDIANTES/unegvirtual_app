import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

import 'package:classroom_app/features/course/presentation/widgets/forms/create_course_form_state.dart';
import 'package:classroom_app/features/course/presentation/widgets/forms/description_input.dart';
import 'package:classroom_app/features/course/presentation/widgets/forms/name_input.dart';

void main() {
  test(
    'status should be initial on initial state',
    () async {
      // act
      final tForm = CreateCourseFormState();

      // assert
      expect(tForm.status, FormzSubmissionStatus.initial);
    },
  );

  group('copyWith', () {
    test(
      'should replace the selected values',
      () async {
        // arrange
        final tForm = CreateCourseFormState(
          description: const DescriptionInput.dirty('my description'),
          name: NameInput.dirty('my name'),
          status: FormzSubmissionStatus.canceled,
        );

        // act
        final result = tForm.copyWith(
          description: const DescriptionInput.dirty('new description'),
          name: NameInput.dirty('new name'),
          status: FormzSubmissionStatus.inProgress,
        );

        // assert
        expect(result.description.value, 'new description');
        expect(result.name.value, 'new name');
        expect(result.status, FormzSubmissionStatus.inProgress);
      },
    );
  });
}
