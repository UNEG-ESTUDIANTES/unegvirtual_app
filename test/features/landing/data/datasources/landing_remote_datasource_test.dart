import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/env/env.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/models/courses_model.dart';
import 'package:unegvirtual_app/features/landing/data/datasources/landing_remote_datasource_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/utils.mocks.dart';

void main() {
  late LandingRemoteDataSourceImpl dataSource;
  late MockClient client;

  setUp(() {
    client = MockClient();
    dataSource = LandingRemoteDataSourceImpl(client: client);
  });

  group('getCourses', () {
    test('should get a request on a URL', () async {
      // arrange
      mockGetResponse(
        client: client,
        response: fixture('courses_search.json'),
        statusCode: 200,
      );

      // act
      dataSource.getCourses();

      // assert
      verify(
        client.get(
          Uri.parse('${Env.appUrl}/v1/courses'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test('should return courses when the response is 200 (success)', () async {
      // arrange
      mockGetResponse(
        client: client,
        response: fixture('courses_search.json'),
        statusCode: 200,
      );

      // act
      final result = await dataSource.getCourses();

      // assert
      expect(result, isA<CoursesModel>());
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: 'Error',
          statusCode: 404,
        );

        // act
        final call = dataSource.getCourses();

        // assert
        expect(() => call, throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      'should throw a ServerException when the call throws a ClientException',
      () async {
        // arrange
        mockGetException(client: client, exception: http.ClientException(''));

        // act
        final call = dataSource.getCourses;

        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
