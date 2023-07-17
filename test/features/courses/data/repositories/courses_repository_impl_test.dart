import 'dart:convert';

import 'package:classroom_app/core/models/course_model.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/course/data/datasources/courses_remote_datasource.dart';
import 'package:classroom_app/features/course/data/models/inscription_model.dart';
import 'package:classroom_app/features/course/data/repositories/courses_repository_impl.dart';
import 'package:classroom_app/features/course/domain/entities/inscription.dart';
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks(
    [MockSpec<CoursesRemoteDataSource>(), MockSpec<NetworkInfo>()])
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

    final input =
        MultiEnroll(studentIds: student, courseId: '1235', auth: '123');

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.multiStudentsEnroll(input);

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.multiStudentEnroll(any))
            .thenAnswer((_) async => true);
        final result = await repository.multiStudentsEnroll(input);

        verify(mockRemoteDataSource.multiStudentEnroll(any));
        final r = Right(result);
        print(r.runtimeType);
      });
    });
  });

  group('Enroled Courses', () {
    final input = '123456';

    final coursesList =
        CoursesModel.fromJson(json.decode(fixture('courses_search.json')));

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.enroledCourses(input);

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.enroledCourses(any))
            .thenAnswer((_) async => coursesList);
        final result = await repository.enroledCourses(input);

        verify(mockRemoteDataSource.enroledCourses(any));
        final r = Right(result);
        print(r.runtimeType);

        expect(result, equals(Right(coursesList)));
      });
    });
  });
}
