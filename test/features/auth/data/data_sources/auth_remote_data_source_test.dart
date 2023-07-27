import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/env/env.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/models/access_token_model.dart';
import 'package:unegvirtual_app/core/models/user_model.dart';
import 'package:unegvirtual_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:unegvirtual_app/features/auth/data/models/user_credentials_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/utils.mocks.dart';

void main() {
  late MockClient client;
  late AuthRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = AuthRemoteDataSourceImpl(client: client);
  });

  const tAccessToken = AccessToken('test');
  final tAccessTokenModel = AccessTokenModel.fromEntity(tAccessToken);

  const tUserModel = UserModel(
    id: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  const tUserCredentialsModel = UserCredentialsModel(
    email: 'test',
    password: 'test',
  );

  group('login', () {
    test(
      '''should perform a POST request with the user 
      credentials and with the application/json header''',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: fixture('access_token.json'),
          statusCode: 200,
        );

        // act
        dataSourceImpl.login(tUserCredentialsModel);

        // assert
        verify(
          client.post(
            Uri.parse('${Env.appUrl}/v1/login'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode(tUserCredentialsModel.toJson()),
          ),
        );
      },
    );

    test(
      'should return AccessTokenModel when status code is 200 (success)',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: fixture('access_token.json'),
          statusCode: 200,
        );

        // act
        final result = await dataSourceImpl.login(tUserCredentialsModel);

        // assert
        expect(result, tAccessTokenModel);
      },
    );

    test(
      'should throw a UserCredentialsMismatchException when status code is 401',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: 'Invalid Credentials',
          statusCode: 401,
        );

        // act
        final call = dataSourceImpl.login;

        // assert
        expect(
          () => call(tUserCredentialsModel),
          throwsA(const TypeMatcher<UserCredentialsMismatchException>()),
        );
      },
    );

    test(
      'should throw a UserNotFoundException when status code is 404',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: 'User not found',
          statusCode: 404,
        );

        // act
        final call = dataSourceImpl.login;

        // assert
        expect(
          () => call(tUserCredentialsModel),
          throwsA(const TypeMatcher<UserNotFoundException>()),
        );
      },
    );

    test(
      'should throw a ServerException when status code is other than 200 and 401',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: 'Unknown Error',
          statusCode: 500,
        );

        // act
        final call = dataSourceImpl.login;

        // assert
        expect(
          () => call(tUserCredentialsModel),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw a ServerException when the call throws a ClientException',
      () async {
        // arrange
        mockPostException(
          client: client,
          exception: http.ClientException(''),
        );

        // act
        final call = dataSourceImpl.login;

        // assert
        expect(
          () => call(tUserCredentialsModel),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('getUser', () {
    test(
      '''should perform a GET request with the access 
      token as the authorization''',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: fixture('user_response.json'),
          statusCode: 200,
        );

        // act
        dataSourceImpl.getUser(tAccessToken);

        // assert
        verify(
          client.get(
            Uri.parse('${Env.appUrl}/v1/me'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tAccessToken.token}'
            },
          ),
        );
      },
    );

    test(
      'should return UserModel when status code is 200 (success)',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: fixture('user_response.json'),
          statusCode: 200,
        );

        // act
        final result = await dataSourceImpl.getUser(tAccessToken);

        // assert
        expect(result, tUserModel);
      },
    );

    test(
      'should throw a UserNotFoundException when status code is 404',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: 'User not found',
          statusCode: 404,
        );

        // act
        final call = dataSourceImpl.getUser;

        // assert
        expect(
          () => call(tAccessToken),
          throwsA(const TypeMatcher<UserNotFoundException>()),
        );
      },
    );

    test(
      'should throw a ServerException when status code is other than 200 and 404',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: 'Unknown Error',
          statusCode: 500,
        );

        // act
        final call = dataSourceImpl.getUser;

        // assert
        expect(
          () => call(tAccessToken),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw a ServerException when the call throws a ClientException',
      () async {
        // arrange
        mockGetException(
          client: client,
          exception: http.ClientException(''),
        );

        // act
        final call = dataSourceImpl.getUser;

        // assert
        expect(
          () => call(tAccessToken),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
