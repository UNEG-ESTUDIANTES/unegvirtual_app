import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/models/access_token_model.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:classroom_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:classroom_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';

@GenerateNiceMocks([
  MockSpec<AuthLocalDataSource>(),
  MockSpec<AuthRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'auth_repository_impl_test.mocks.dart';

void main() {
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = AuthRepositoryImpl(
      localDataSource: mockAuthLocalDataSource,
      remoteDataSource: mockAuthRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tAccessTokenModel = AccessTokenModel('test');
  const AccessToken tAccessToken = tAccessTokenModel;

  const tUserCredentials = UserCredentials(
    email: 'test',
    password: 'test',
  );

  group('login', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.login(tUserCredentials);

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should call the proper method to login the user',
        () async {
          // arrange
          when(mockAuthRemoteDataSource.login(any))
              .thenAnswer((_) async => tAccessTokenModel);

          // act
          final result = await repository.login(tUserCredentials);

          // assert
          expect(result, const Right(tAccessTokenModel));
          verify(mockAuthRemoteDataSource.login(any));
          verifyZeroInteractions(mockAuthLocalDataSource);
        },
      );

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockAuthRemoteDataSource.login(any))
              .thenAnswer((_) async => tAccessTokenModel);

          // act
          final result = await repository.login(tUserCredentials);

          // assert
          verify(mockAuthRemoteDataSource.login(tUserCredentials));
          expect(result, const Right(tAccessToken));
        },
      );

      test(
        '''should return UserCredentialsMismatchFailure when the call 
        to remote data throws an UserCredentialsMismatchException''',
        () async {
          // arrange
          when(mockAuthRemoteDataSource.login(any))
              .thenThrow(UserCredentialsMismatchException());

          // act
          final result = await repository.login(tUserCredentials);

          // assert
          verify(mockAuthRemoteDataSource.login(tUserCredentials));
          expect(result, Left(UserCredentialsMismatchFailure()));
        },
      );

      test(
        '''should return ServerFailure when the call 
        to remote data throws a ServerException''',
        () async {
          // arrange
          when(mockAuthRemoteDataSource.login(any))
              .thenThrow(ServerException());

          // act
          final result = await repository.login(tUserCredentials);

          // assert
          verify(mockAuthRemoteDataSource.login(tUserCredentials));
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
          final result = await repository.login(tUserCredentials);

          // assert
          verifyZeroInteractions(mockAuthRemoteDataSource);
          expect(result, Left(NoInternetConnectionFailure()));
        },
      );
    });
  });
}
