import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/models/user_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
    id: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  test(
    'should be a subclass of User entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));

        // act
        final result = UserModel.fromJson(jsonMap);

        // assert
        expect(result, tUserModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tUserModel.toJson();

        // assert
        final expectedMap = {
          "_id": tUserModel.id,
          "firstName": tUserModel.firstName,
          "lastName": tUserModel.lastName,
          "ci": tUserModel.identityCard,
          "email": tUserModel.email,
        };

        expect(result, expectedMap);
      },
    );
  });
}
