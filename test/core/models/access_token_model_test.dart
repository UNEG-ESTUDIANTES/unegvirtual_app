import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/models/access_token_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tAccessTokenModel = AccessTokenModel('test');

  test(
    'should be a subclass of AccessToken entity',
    () async {
      // assert
      expect(tAccessTokenModel, isA<AccessToken>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('access_token.json'));

        // act
        final result = AccessTokenModel.fromJson(jsonMap);

        // assert
        expect(result, tAccessTokenModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tAccessTokenModel.toJson();

        // assert
        final expectedMap = {
          "token": tAccessTokenModel.token,
        };

        expect(result, expectedMap);
      },
    );
  });
}
