import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/auth.dart';
import 'package:unegvirtual_app/core/entities/user.dart';
import 'package:unegvirtual_app/core/models/access_token_model.dart';
import 'package:unegvirtual_app/core/models/auth_model.dart';
import 'package:unegvirtual_app/core/models/user_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tAuthModel = AuthModel(
    accessToken: AccessToken('test'),
    user: User(
      id: 'test',
      firstName: 'test',
      lastName: 'test',
      identityCard: 'test',
      email: 'test',
    ),
  );

  test(
    'should be a subclass of Auth entity',
    () async {
      // assert
      expect(tAuthModel, isA<Auth>());
    },
  );

  group('accessToken', () {
    test(
      'should be a AccessTokenModel',
      () async {
        // assert
        expect(tAuthModel.accessToken, isA<AccessTokenModel>());
      },
    );
  });

  group('user', () {
    test(
      'should be a UserModel',
      () async {
        // assert
        expect(tAuthModel.user, isA<UserModel>());
      },
    );
  });

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('auth.json'));

        // act
        final result = AuthModel.fromJson(jsonMap);

        // assert
        expect(result, tAuthModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tAuthModel.toJson();

        // assert
        final expectedMap = {
          "accessToken": tAuthModel.accessToken.toJson(),
          "user": tAuthModel.user.toJson(),
        };

        expect(result, expectedMap);
      },
    );
  });
}
