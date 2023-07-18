import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/models/courses_model.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/course/data/datasources/courses_remote_datasource.dart';
import 'package:classroom_app/features/course/data/repositories/courses_repository_impl.dart';
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([
  MockSpec<CoursesRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'courses_repository_impl_test.mocks.dart';

void main() {
  late CoursesRepositoryImpl repository;
  late MockCoursesRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockCoursesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CoursesRepositoryImpl(
      remote: mockRemoteDataSource,
      network: mockNetworkInfo,
    );
  });

  const tAccessToken = AccessToken('test');

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('Enroll multi students', () {
    const student = [
      "64b4868166d7f87437caaf50",
      "64b4867066d7f87437caaf4d",
      "64b4864866d7f87437caaf49"
    ];

    const input = MultiEnroll(
      studentIds: student,
      courseId: '1235',
    );

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.multiStudentsEnroll(
        input,
        tAccessToken,
      );

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.multiStudentEnroll(any, any))
            .thenAnswer((_) async => true);

        await repository.multiStudentsEnroll(input, tAccessToken);

        verify(mockRemoteDataSource.multiStudentEnroll(input, tAccessToken));
      });
    });
  });

  group('Enroled Courses', () {
    final coursesList =
        CoursesModel.fromJson(json.decode(fixture('courses_search.json')));

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.enroledCourses(tAccessToken);

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.enroledCourses(any))
            .thenAnswer((_) async => coursesList);

        final result = await repository.enroledCourses(tAccessToken);

        verify(mockRemoteDataSource.enroledCourses(any));

        expect(result, equals(Right(coursesList)));
      });
    });
  });
}
