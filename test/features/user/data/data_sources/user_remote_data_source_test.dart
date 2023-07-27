import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/env/env.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:unegvirtual_app/features/user/data/models/unsaved_user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/utils.mocks.dart';

void main() {
  late MockClient client;
  late UserRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = UserRemoteDataSourceImpl(client: client);
  });

  const tAccessToken = AccessToken('test');

  const tUnsavedUserModel = UnsavedUserModel(
    password: 'test',
    securityKey: 'test',
    type: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  group('createUser', () {
    test(
      '''should perform a POST request with the unsaved user
      and with the application/json header''',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: fixture('user_response.json'),
          statusCode: 200,
        );

        // act
        dataSourceImpl.createUser(
          accessToken: tAccessToken,
          unsavedUser: tUnsavedUserModel,
        );

        // assert
        verify(
          client.post(
            Uri.parse('${Env.appUrl}/v1/signupUser'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tAccessToken.token}',
            },
            body: json.encode(tUnsavedUserModel.toJson()),
          ),
        );
      },
    );

    test(
      'should throw NotAuthorizedException when status code is 401',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: 'Not and admin',
          statusCode: 401,
        );

        // act
        final call = dataSourceImpl.createUser;

        // assert
        expect(
          () => call(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUserModel,
          ),
          throwsA(const TypeMatcher<NotAuthorizedException>()),
        );
      },
    );

    test(
      'should throw EmailTakenException when status code is 409',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: 'Email taken',
          statusCode: 409,
        );

        // act
        final call = dataSourceImpl.createUser;

        // assert
        expect(
          () => call(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUserModel,
          ),
          throwsA(const TypeMatcher<EmailTakenException>()),
        );
      },
    );

    test(
      'should throw ServerException when status code is other than 200, 401 and 409',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: 'Unknown error',
          statusCode: 500,
        );

        // act
        final call = dataSourceImpl.createUser;

        // assert
        expect(
          () => call(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUserModel,
          ),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw a ServerException when the call throws a ClientException',
      () async {
        // arrange
        when(
          client.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenThrow(http.ClientException(''));

        // act
        final call = dataSourceImpl.createUser;

        // assert
        expect(
          () => call(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUserModel,
          ),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
