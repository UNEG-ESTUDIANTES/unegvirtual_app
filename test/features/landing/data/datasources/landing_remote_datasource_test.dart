import 'package:classroom_app/core/error/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'package:classroom_app/features/landing/data/datasources/landing_remote_datasource_impl.dart';
import 'package:classroom_app/features/landing/data/models/course_model.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'landing_remote_datasource_test.mocks.dart';

void main() {
  late LandingRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = LandingRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200Courses() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('courses_search.json'), 200));
  }

  void setUpMockHttpClientFail404Courses() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('courses_search.json'), 404));
  }

  group('get courses', () {
    test('should Get a request on a URL', () async {
      setUpMockHttpClientSuccess200Courses();
      dataSource.getCourses();
      verify(mockHttpClient.get(Uri.parse('http://0.0.0.0:3000/v1/courses'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return Sports when the response is 200(success)', () async {
      setUpMockHttpClientSuccess200Courses();
      final result = await dataSource.getCourses();
      expect(result, isA<CourseModel>());
    });

    test(
        'should throw a ServerExeption trying a random number when the response code is 404 or other',
        () async {
      setUpMockHttpClientFail404Courses();
      final call = dataSource.getCourses();
      expect(() => call, throwsA(ServerFailure()));
    });
  });
}
