import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/core/env/env.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/models/course_model.dart';
import 'package:classroom_app/core/models/courses_model.dart';
import 'package:classroom_app/features/course/data/datasources/courses_remote_datasource.dart';
import 'package:classroom_app/features/course/data/models/new_course_model.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'courses_remote_datasource_test.mocks.dart';

void main() {
  late MockClient client;
  late CoursesRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = CoursesRemoteDataSourceImpl(client: client);
  });

  const tCourseModel = CourseModel(
    id: 'test',
    name: 'test',
    description: 'test',
    teacherId: 'test',
  );

  const tCoursesModel = CoursesModel(courses: [tCourseModel]);

  const tNewCourseModel = NewCourseModel(
    name: 'test',
    description: 'test',
    teacherId: 'test',
  );

  const tAccessToken = AccessToken('test');

  group('getCourses', () {
    void setUpMockHttpClientSuccess200() {
      when(
        client.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('courses.json'),
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
          'Invalid',
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
          'Unknown error',
          500,
        ),
      );
    }

    test(
      'should perform a GET request with the application/json header',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        dataSourceImpl.getCourses();

        // assert
        verify(
          client.get(
            Uri.parse('${Env.appUrl}/v1/courses'),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
      },
    );

    test(
      'should return a CoursesModel when status code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSourceImpl.getCourses();

        // assert
        expect(result, tCoursesModel);
      },
    );

    test(
      'should throw NotFoundException when status code is 404',
      () async {
        // arrange
        setUpMockHttpClientError404();

        // act
        final call = dataSourceImpl.getCourses;

        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<NotFoundException>()),
        );
      },
    );

    test(
      'should throw ServerException when status code is other than 200 and 404',
      () async {
        // arrange
        setUpMockHttpClientGeneralError();

        // act
        final call = dataSourceImpl.getCourses;

        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw ServerException when status code is other than 200 and 404',
      () async {
        // arrange
        when(
          client.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenThrow(http.ClientException(''));

        // act
        final call = dataSourceImpl.getCourses;

        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('postCourse', () {
    void setUpMockHttpClientSuccess200() {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('new_course_response.json'),
          200,
        ),
      );
    }

    void setUpMockHttpClientError403() {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'User not authed',
          403,
        ),
      );
    }

    void setUpMockHttpClientGeneralError() {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Unknown Error',
          500,
        ),
      );
    }

    test(
      '''should perform a POST request with the bearer token
      and with the application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        dataSourceImpl.postCourse(
          newCourse: tNewCourseModel,
          accessToken: tAccessToken,
        );

        // assert
        verify(
          client.post(
            Uri.parse('${Env.appUrl}/v1/courses'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tAccessToken.token}'
            },
            body: json.encode(tNewCourseModel.toJson()),
          ),
        );
      },
    );

    test(
      'should return a CourseModel when the status code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSourceImpl.postCourse(
          newCourse: tNewCourseModel,
          accessToken: tAccessToken,
        );

        // assert
        expect(result, tCourseModel);
      },
    );

    test(
      'should throw NotAuthorizedException when status code is 403',
      () async {
        // arrange
        setUpMockHttpClientError403();

        // act
        final call = dataSourceImpl.postCourse;

        // assert
        expect(
          () => call(
            newCourse: tNewCourseModel,
            accessToken: tAccessToken,
          ),
          throwsA(const TypeMatcher<NotAuthorizedException>()),
        );
      },
    );

    test(
      'should throw ServerException when status code is other than 200 and 403',
      () async {
        // arrange
        setUpMockHttpClientGeneralError();

        // act
        final call = dataSourceImpl.postCourse;

        // assert
        expect(
          () => call(
            newCourse: tNewCourseModel,
            accessToken: tAccessToken,
          ),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw ServerException when status code is other than 200 and 403',
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
        final call = dataSourceImpl.postCourse;

        // assert
        expect(
          () => call(
            newCourse: tNewCourseModel,
            accessToken: tAccessToken,
          ),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
