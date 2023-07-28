import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/models/courses_model.dart';
import 'package:unegvirtual_app/core/network/network_info.dart';
import 'package:unegvirtual_app/features/course/data/datasources/courses_remote_datasource.dart';
import 'package:unegvirtual_app/features/course/data/models/multi_enroll_model.dart';
import 'package:unegvirtual_app/features/course/data/repositories/courses_repository_impl.dart';
import 'package:unegvirtual_app/features/course/domain/entities/multi_enroll.dart';

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

  const tCoursesModel = CoursesModel(courses: []);

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('getCourses', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.getCourses();

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should call the proper method to get courses',
        () async {
          // arrange
          when(mockRemoteDataSource.getCourses())
              .thenAnswer((_) async => tCoursesModel);

          // act
          await repository.getCourses();

          // assert
          verify(mockRemoteDataSource.getCourses());
        },
      );

      test(
        'should return remote data when the call to remote data is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCourses())
              .thenAnswer((_) async => tCoursesModel);

          // act
          final result = await repository.getCourses();

          // assert
          expect(result, const Right(tCoursesModel));
          verify(mockRemoteDataSource.getCourses());
        },
      );

      test(
        '''should return NotFoundFailure when the call
        to remote data throws an NotFoundException''',
        () async {
          // arrange
          when(mockRemoteDataSource.getCourses())
              .thenThrow(NotFoundException());

          // act
          final result = await repository.getCourses();

          // assert
          verify(mockRemoteDataSource.getCourses());
          expect(result, Left(NotFoundFailure()));
        },
      );

      test(
        '''should return ServerFailure when the call
        to remote data throws an ServerException''',
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

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return NoInternetConnectionFailure',
        () async {
          // act
          final result = await repository.getCourses();

          // assert
          expect(result, Left(NoInternetConnectionFailure()));
        },
      );
    });
  });

  group('multiStudentsEnroll', () {
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
        multiEnroll: input,
        accessToken: tAccessToken,
      );

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(
          mockRemoteDataSource.multiStudentEnroll(
            accessToken: anyNamed('accessToken'),
            multiEnroll: anyNamed('multiEnroll'),
          ),
        ).thenAnswer((_) async => true);

        await repository.multiStudentsEnroll(
          multiEnroll: input,
          accessToken: tAccessToken,
        );

        verify(
          mockRemoteDataSource.multiStudentEnroll(
            multiEnroll: MultiEnrollModel.fromEntity(input),
            accessToken: tAccessToken,
          ),
        );
      });
    });
  });

  group('getEnrolledCourses', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.getEnrolledCourses(tAccessToken);

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestOnline(() {
      test(
        'should call the proper method to get the enrolled courses',
        () async {
          // arrange
          when(mockRemoteDataSource.getEnrolledCourses(any))
              .thenAnswer((_) async => tCoursesModel);

          // act
          await repository.getEnrolledCourses(tAccessToken);

          // assert
          verify(mockRemoteDataSource.getEnrolledCourses(tAccessToken));
        },
      );

      test(
        'should return remote data when the call is successfull',
        () async {
          // arrange
          when(mockRemoteDataSource.getEnrolledCourses(any))
              .thenAnswer((_) async => tCoursesModel);

          // act
          final result = await repository.getEnrolledCourses(tAccessToken);

          // assert
          verify(mockRemoteDataSource.getEnrolledCourses(any));
          expect(result, equals(const Right(tCoursesModel)));
        },
      );

      test(
        '''should return NotEnrolledFailure when the call
        to remote data throws a NotEnrolledException''',
        () async {
          // arrange
          when(mockRemoteDataSource.getEnrolledCourses(any))
              .thenThrow(NotEnrolledException());

          // act
          final result = await repository.getEnrolledCourses(tAccessToken);

          // assert
          verify(mockRemoteDataSource.getEnrolledCourses(tAccessToken));
          expect(result, Left(NotEnrolledFailure()));
        },
      );

      test(
        '''should return ServerFailure when the call
        to remote data throws a ServerException''',
        () async {
          // arrange
          when(mockRemoteDataSource.getEnrolledCourses(any))
              .thenThrow(ServerException());

          // act
          final result = await repository.getEnrolledCourses(tAccessToken);

          // assert
          verify(mockRemoteDataSource.getEnrolledCourses(tAccessToken));
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return NoInternetConnectionFailure',
        () async {
          // act
          final result = await repository.getEnrolledCourses(tAccessToken);

          // assert
          expect(result, Left(NoInternetConnectionFailure()));
        },
      );
    });
  });
}
