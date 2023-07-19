import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/models/courses_model.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/landing/data/datasources/landing_remote_datasource_impl.dart';
import 'package:classroom_app/features/landing/data/repositories/landing_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks(
    [MockSpec<LandingRemoteDataSourceImpl>(), MockSpec<NetworkInfo>()])
import 'landing_repository_impl_test.mocks.dart';

void main() {
  late LandingRepositoryImpl repository;
  late MockLandingRemoteDataSourceImpl mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockLandingRemoteDataSourceImpl();
    mockNetworkInfo = MockNetworkInfo();
    repository = LandingRepositoryImpl(
        network: mockNetworkInfo, remote: mockRemoteDataSource);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('getCourses', () {
    final coursesList =
        CoursesModel.fromJson(json.decode(fixture('courses_search.json')));

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getCourses();

      verify(mockNetworkInfo.isConnected);
    });

    group('device is offline', () {
      test(
        'should return ServerFailure when device is offline',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

          // act
          final result = await repository.getCourses();

          // assert
          verifyNever(mockRemoteDataSource.getCourses());
          expect(result, Left(ServerFailure()));
        },
      );
    });

    runTestOnline(() {
      test('should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.getCourses())
            .thenAnswer((_) async => coursesList);
        final result = await repository.getCourses();

        verify(mockRemoteDataSource.getCourses());
        expect(result, equals(Right(coursesList)));
      });

      test(
        'should return ServerFailure when the call to remote data throws a ServerException',
        () async {
          // arrange
          when(mockRemoteDataSource.getCourses()).thenThrow(ServerException());

          // act
          final result = await repository.getCourses();

          // assert
          verify(mockRemoteDataSource.getCourses());
          expect(result, Left(ServerFailure()));
        },
      );
    });
  });
}
