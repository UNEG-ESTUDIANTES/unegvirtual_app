import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/models/courses_model.dart';
import 'package:classroom_app/features/landing/data/datasources/landing_remote_datasource_impl.dart';
import 'package:classroom_app/features/landing/data/repositories/landing_repository_impl.dart';

import '../../../../../lib/core/network/network_info.dart';
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

  group('Get Sports List', () {
    final coursesList =
        CoursesModel.fromJson(json.decode(fixture('courses_search.json')));

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getCourses();

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.getCourses())
            .thenAnswer((_) async => coursesList);
        final result = await repository.getCourses();

        verify(mockRemoteDataSource.getCourses());
        final r = Right(result);
        print(r.runtimeType);
        print(coursesList.runtimeType);
        expect(result, equals(Right(coursesList)));
      });
    });
  });
}
