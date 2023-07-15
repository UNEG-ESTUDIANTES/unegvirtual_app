import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/features/auth/data/models/user_credentials_model.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';

void main() {
  const tUserCredentialsModel = UserCredentialsModel(
    email: 'test',
    password: 'test',
  );

  test(
    'should be a subclass of UserCredentials entity',
    () async {
      // assert
      expect(tUserCredentialsModel, isA<UserCredentials>());
    },
  );

  group('fromEntity', () {
    const tUserCredentials = UserCredentials(
      email: 'test',
      password: 'test',
    );

    test(
      'should return an UserCredentialsModel',
      () async {
        // act
        final result = UserCredentialsModel.fromEntity(tUserCredentials);

        // assert
        expect(result, isA<UserCredentialsModel>());
      },
    );

    test(
      'should contain the same data as the UserCredentials',
      () async {
        // act
        final result = UserCredentialsModel.fromEntity(tUserCredentials);

        // assert
        expect(result.email, tUserCredentials.email);
        expect(result.password, tUserCredentials.password);
      },
    );
  });

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
