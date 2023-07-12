import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/features/auth/data/models/user_credentials_model.dart';

void main() {
  const tUserCredentialsModel = UserCredentialsModel(
    email: 'test',
    password: 'test',
  );

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tUserCredentialsModel.toJson();

        // assert
        final expectedMap = {
          'email': tUserCredentialsModel.email,
          'password': tUserCredentialsModel.password
        };

        expect(result, expectedMap);
      },
    );
  });
}
