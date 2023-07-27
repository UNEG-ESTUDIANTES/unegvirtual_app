import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/env/env.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/models/course_model.dart';
import 'package:unegvirtual_app/core/models/courses_model.dart';
import 'package:unegvirtual_app/features/course/data/datasources/courses_remote_datasource.dart';
import 'package:unegvirtual_app/features/course/data/models/inscription_model.dart';
import 'package:unegvirtual_app/features/course/data/models/multi_enroll_model.dart';
import 'package:unegvirtual_app/features/course/data/models/new_course_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/utils.mocks.dart';

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

  const tInscriptionModel = InscriptionModel(
    courseId: 'test',
    studentId: 'test',
  );

  const tMultiEnrollModel = MultiEnrollModel(courseId: 'test', studentIds: []);

  group('coursesGetCourses', () {
    test(
      'should perform a GET request with the application/json header',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: fixture('courses.json'),
          statusCode: 200,
        );

        // act
        dataSourceImpl.coursesGetCourses();

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
        mockGetResponse(
          client: client,
          response: fixture('courses.json'),
          statusCode: 200,
        );

        // act
        final result = await dataSourceImpl.coursesGetCourses();

        // assert
        expect(result, tCoursesModel);
      },
    );

    test(
      'should throw NotFoundException when status code is 404',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: 'Error',
          statusCode: 404,
        );

        // act
        final call = dataSourceImpl.coursesGetCourses;

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
        mockGetResponse(
          client: client,
          response: 'Error',
          statusCode: 500,
        );

        // act
        final call = dataSourceImpl.coursesGetCourses;

        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw ServerException when ClientException occurs',
      () async {
        // arrange
        mockGetException(
          client: client,
          exception: http.ClientException(''),
        );

        // act
        final call = dataSourceImpl.coursesGetCourses;

        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('postCourse', () {
    test(
      '''should perform a POST request with the bearer token
      and with the application/json header''',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: fixture('new_course_response.json'),
          statusCode: 200,
        );

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
        mockPostResponse(
          client: client,
          response: fixture('new_course_response.json'),
          statusCode: 200,
        );

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
        mockPostResponse(
          client: client,
          response: 'Error',
          statusCode: 403,
        );

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
        mockPostResponse(
          client: client,
          response: 'Error',
          statusCode: 500,
        );

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
      'should throw ServerException when occurs a ClientException',
      () async {
        // arrange
        mockPostException(
          client: client,
          exception: http.ClientException(''),
        );

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

  group('enrollStudent', () {
    test(
      '''should perform a POST request with the bearer token
      and with the application/json header''',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: fixture('enroll_student_response.json'),
          statusCode: 200,
        );

        // act
        dataSourceImpl.enrollStudent(
          inscription: tInscriptionModel,
          accessToken: tAccessToken,
        );

        // assert
        verify(
          client.post(
            Uri.parse(
              '${Env.appUrl}/v1/courses/${tInscriptionModel.courseId}/users/${tInscriptionModel.studentId}/inscriptions',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tAccessToken.token}'
            },
            body: json.encode(tInscriptionModel.toJson()),
          ),
        );
      },
    );

    test(
      'should return an InscriptionModel when the status code is 200 (success)',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: fixture('enroll_student_response.json'),
          statusCode: 200,
        );

        // act
        final result = await dataSourceImpl.enrollStudent(
          inscription: tInscriptionModel,
          accessToken: tAccessToken,
        );

        // assert
        expect(result, tInscriptionModel);
      },
    );

    test(
      'should throw NotAuthorizedException when status code is 403',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: 'Error',
          statusCode: 403,
        );

        // act
        final call = dataSourceImpl.enrollStudent;

        // assert
        expect(
          () => call(
            inscription: tInscriptionModel,
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
        mockPostResponse(
          client: client,
          response: 'Error',
          statusCode: 500,
        );

        // act
        final call = dataSourceImpl.enrollStudent;

        // assert
        expect(
          () => call(
            inscription: tInscriptionModel,
            accessToken: tAccessToken,
          ),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw ServerException when occurs a ClientException',
      () async {
        // arrange
        mockPostException(
          client: client,
          exception: http.ClientException(''),
        );

        // act
        final call = dataSourceImpl.enrollStudent;

        // assert
        expect(
          () => call(
            inscription: tInscriptionModel,
            accessToken: tAccessToken,
          ),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('enroledCourses', () {
    test(
      '''should perform a GET request with the bearer token and
      with the application/json header''',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: fixture('courses.json'),
          statusCode: 200,
        );

        // act
        dataSourceImpl.enroledCourses(tAccessToken);

        // assert
        verify(
          client.get(
            Uri.parse('${Env.appUrl}/v1/enrolledCourses'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tAccessToken.token}'
            },
          ),
        );
      },
    );

    test(
      'should return a CoursesModel when the status code is 200 (success)',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: fixture('courses.json'),
          statusCode: 200,
        );

        // act
        final result = await dataSourceImpl.enroledCourses(tAccessToken);

        // assert
        expect(result, tCoursesModel);
      },
    );

    test(
      'should throw NotEnrolledException when status code is 404',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: 'Error',
          statusCode: 404,
        );

        // act
        final call = dataSourceImpl.enroledCourses;

        // assert
        expect(
          () => call(tAccessToken),
          throwsA(const TypeMatcher<NotEnrolledException>()),
        );
      },
    );

    test(
      'should throw ServerException when status code is other than 200 and 403',
      () async {
        // arrange
        mockGetResponse(
          client: client,
          response: 'Error',
          statusCode: 500,
        );

        // act
        final call = dataSourceImpl.enroledCourses;

        // assert
        expect(
          () => call(tAccessToken),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw ServerException when occurs a ClientException',
      () async {
        // arrange
        mockGetException(
          client: client,
          exception: http.ClientException(''),
        );

        // act
        final call = dataSourceImpl.enroledCourses;

        // assert
        expect(
          () => call(tAccessToken),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('multiStudentEnroll', () {
    test(
      '''should perform a POST request with the bearer token
      and with the application/json header''',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: fixture('enroll_multiple_students_response.json'),
          statusCode: 200,
        );

        // act
        dataSourceImpl.multiStudentEnroll(
          multiEnroll: tMultiEnrollModel,
          accessToken: tAccessToken,
        );

        // assert
        verify(
          client.post(
            Uri.parse(
              '${Env.appUrl}/v1/courses/enroll-multiple-users',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tAccessToken.token}'
            },
            body: json.encode(tMultiEnrollModel.toJson()),
          ),
        );
      },
    );

    test(
      'should return nothing when the status code is 200 (success)',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: fixture('enroll_multiple_students_response.json'),
          statusCode: 200,
        );

        // act
        await dataSourceImpl.multiStudentEnroll(
          multiEnroll: tMultiEnrollModel,
          accessToken: tAccessToken,
        );
      },
    );

    test(
      'should throw NotAuthorizedException when status code is 403',
      () async {
        // arrange
        mockPostResponse(
          client: client,
          response: 'Error',
          statusCode: 403,
        );

        // act
        final call = dataSourceImpl.multiStudentEnroll;

        // assert
        expect(
          () => call(
            multiEnroll: tMultiEnrollModel,
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
        mockPostResponse(
          client: client,
          response: 'Error',
          statusCode: 500,
        );

        // act
        final call = dataSourceImpl.multiStudentEnroll;

        // assert
        expect(
          () => call(
            multiEnroll: tMultiEnrollModel,
            accessToken: tAccessToken,
          ),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw ServerException when occurs a ClientException',
      () async {
        // arrange
        mockPostException(
          client: client,
          exception: http.ClientException(''),
        );

        // act
        final call = dataSourceImpl.multiStudentEnroll;

        // assert
        expect(
          () => call(
            multiEnroll: tMultiEnrollModel,
            accessToken: tAccessToken,
          ),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
