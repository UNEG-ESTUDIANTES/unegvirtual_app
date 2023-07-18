import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/models/access_token_model.dart';
import 'package:classroom_app/core/models/user_model.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/user/data/data_sources/user_local_data_source.dart';
import 'package:classroom_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:classroom_app/features/user/data/repositories/user_repository_impl.dart';

@GenerateNiceMocks([
  MockSpec<UserLocalDataSource>(),
  MockSpec<UserRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'user_repository_impl_test.mocks.dart';

void main() {
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late UserRepositoryImpl repository;

  setUp(() {
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = UserRepositoryImpl(
      localDataSource: mockUserLocalDataSource,
      remoteDataSource: mockUserRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tUserModel = UserModel(
    id: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  const User tUser = tUserModel;
  const tAccessTokenModel = AccessTokenModel('test');
  const AccessToken tAccessToken = tAccessTokenModel;

  group('getCurrentUser', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.getCurrentUser(tAccessToken);

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should call the proper method to get the current user',
        () async {
          // arrange
          when(mockUserRemoteDataSource.getCurrentUser(any))
              .thenAnswer((_) async => tUserModel);

          // act
          final result = await repository.getCurrentUser(tAccessToken);

          // assert
          expect(result, const Right(tUserModel));
          verify(mockUserRemoteDataSource.getCurrentUser(tAccessTokenModel));
        },
      );

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockUserRemoteDataSource.getCurrentUser(any))
              .thenAnswer((_) async => tUserModel);

          // act
          final result = await repository.getCurrentUser(tAccessToken);

          // assert
          verify(mockUserRemoteDataSource.getCurrentUser(tAccessTokenModel));
          expect(result, const Right(tUser));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockUserRemoteDataSource.getCurrentUser(any))
              .thenAnswer((_) async => tUserModel);

          // act
          await repository.getCurrentUser(tAccessToken);

          // assert
          verify(mockUserRemoteDataSource.getCurrentUser(tAccessTokenModel));
          verify(mockUserLocalDataSource.cacheUser(tUserModel));
        },
      );

      test(
        '''should return UserNotFoundFailure when the call
        to remote data throws an UserNotFoundException''',
        () async {
          // arrange
          when(mockUserRemoteDataSource.getCurrentUser(any))
              .thenThrow(UserNotFoundException());

          // act
          final result = await repository.getCurrentUser(tAccessToken);

          // assert
          verify(mockUserRemoteDataSource.getCurrentUser(tAccessTokenModel));
          expect(result, Left(UserNotFoundFailure()));
        },
      );

      group('the call to remote data throws a ServerException', () {
        setUp(() {
          when(mockUserRemoteDataSource.getCurrentUser(any))
              .thenThrow(ServerException());
        });

        test(
          'should get the user locally',
          () async {
            // arrange
            when(mockUserLocalDataSource.getCurrentUser())
                .thenAnswer((_) async => tUserModel);

            // act
            final result = await repository.getCurrentUser(tAccessToken);

            // assert
            verify(mockUserLocalDataSource.getCurrentUser());
            expect(result, const Right(tUserModel));
          },
        );

        test(
          '''should return NotFoundFailure when the call 
        to local data throws a NotFoundException''',
          () async {
            // arrange
            when(mockUserLocalDataSource.getCurrentUser())
                .thenThrow(NotFoundException());

            // act
            final result = await repository.getCurrentUser(tAccessToken);

            // assert
            verify(mockUserLocalDataSource.getCurrentUser());
            expect(result, Left(NotFoundFailure()));
          },
        );

        test(
          '''should return CacheFailure when the call
          to remote data throws a CacheException''',
          () async {
            // arrange
            when(mockUserLocalDataSource.getCurrentUser())
                .thenThrow(CacheException());

            // act
            final result = await repository.getCurrentUser(tAccessToken);

            // assert
            verify(mockUserLocalDataSource.getCurrentUser());
            expect(result, Left(CacheFailure()));
          },
        );
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return local data when the call to local data source is successful',
        () async {
          // arrange
          when(mockUserLocalDataSource.getCurrentUser())
              .thenAnswer((_) async => tUserModel);

          // act
          final result = await repository.getCurrentUser(tAccessToken);

          // assert
          expect(result, const Right(tUserModel));
          verify(mockUserLocalDataSource.getCurrentUser());
          verifyZeroInteractions(mockUserRemoteDataSource);
        },
      );

      test(
        '''should return NotFoundFailure when the call 
        to local data throws a NotFoundException''',
        () async {
          // arrange
          when(mockUserLocalDataSource.getCurrentUser())
              .thenThrow(NotFoundException());

          // act
          final result = await repository.getCurrentUser(tAccessToken);

          // assert
          verify(mockUserLocalDataSource.getCurrentUser());
          expect(result, Left(NotFoundFailure()));
        },
      );

      test(
        '''should return CacheFailure when the call 
        to local data throws a CacheException''',
        () async {
          // arrange
          when(mockUserLocalDataSource.getCurrentUser())
              .thenThrow(CacheException());

          // act
          final result = await repository.getCurrentUser(tAccessToken);

          // assert
          verify(mockUserLocalDataSource.getCurrentUser());
          expect(result, Left(CacheFailure()));
        },
      );
    });
  });
}
