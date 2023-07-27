import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

import 'package:unegvirtual_app/core/forms/email_input.dart';
import 'package:unegvirtual_app/features/auth/presentation/widgets/forms/login_form_state.dart';
import 'package:unegvirtual_app/core/forms/password_input.dart';

void main() {
  test(
    'status should be initial on initial state',
    () async {
      // act
      final tForm = LoginFormState();

      // assert
      expect(tForm.status, FormzSubmissionStatus.initial);
    },
  );

  group('copyWith', () {
    test(
      'should replace the selected values',
      () async {
        // arrange
        final tForm = LoginFormState(
            email: EmailInput.dirty('test@gmail.com'),
            password: const PasswordInput.pure(),
            status: FormzSubmissionStatus.initial);

        // act
        final result = tForm.copyWith(
          password: const PasswordInput.dirty('test'),
        );

        // assert
        expect(result.password.value, 'test');
      },
    );
  });
}
