import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/env/env.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/models/user_model.dart';
import 'package:classroom_app/features/user/data/data_sources/user_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'user_remote_data_source_test.mocks.dart';

void main() {
  late MockClient client;
  late UserRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = UserRemoteDataSourceImpl(client: client);
  });

  const tAccessToken = AccessToken('test');

  const tUserModel = UserModel(
    id: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  group('getCurrentUser', () {
    void setUpMockHttpClientSuccess200() {
      when(
        client.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('user_response.json'),
          200,
        ),
      );
    }

    void setUpMockHttpClientError404() {
      when(
        client.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'User not found',
          404,
        ),
      );
    }

    void setUpMockHttpClientGeneralError() {
      when(
        client.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Unknown Error',
          500,
        ),
      );
    }

    void setUpMockHttpClientException() {
      when(
        client.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenThrow(http.ClientException(''));
    }

    test(
      '''should perform a GET request with the access 
      token as the authorization''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        dataSourceImpl.getCurrentUser(tAccessToken);

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
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSourceImpl.getCurrentUser(tAccessToken);

        // assert
        expect(result, tUserModel);
      },
    );

    test(
      'should throw a UserNotFoundException when status code is 404',
      () async {
        // arrange
        setUpMockHttpClientError404();

        // act
        final call = dataSourceImpl.getCurrentUser;

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
        setUpMockHttpClientGeneralError();

        // act
        final call = dataSourceImpl.getCurrentUser;

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
        setUpMockHttpClientException();

        // act
        final call = dataSourceImpl.getCurrentUser;

        // assert
        expect(
          () => call(tAccessToken),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
