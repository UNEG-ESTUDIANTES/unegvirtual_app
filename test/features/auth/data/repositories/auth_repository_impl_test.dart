import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/user.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/models/access_token_model.dart';
import 'package:unegvirtual_app/core/models/auth_model.dart';
import 'package:unegvirtual_app/core/models/user_model.dart';
import 'package:unegvirtual_app/core/network/network_info.dart';
import 'package:unegvirtual_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:unegvirtual_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:unegvirtual_app/features/auth/data/models/user_credentials_model.dart';
import 'package:unegvirtual_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:unegvirtual_app/features/auth/domain/entities/user_credentials.dart';

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

  final tUserCredentialsModel = UserCredentialsModel.fromEntity(
    tUserCredentials,
  );

  const tUser = User(
    id: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  final tUserModel = UserModel.fromEntity(tUser);

  const tAuthModel = AuthModel(
    accessToken: tAccessToken,
    user: tUser,
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

      void successfulCall() {
        when(mockAuthRemoteDataSource.login(any))
            .thenAnswer((_) async => tAccessTokenModel);

        when(mockAuthRemoteDataSource.getUser(any))
            .thenAnswer((_) async => tUserModel);
      }

      test(
        'should call the proper method to login the user',
        () async {
          // arrange
          successfulCall();

          // act
          final result = await repository.login(tUserCredentials);

          // assert
          expect(result, const Right(tAuthModel));
          verify(mockAuthRemoteDataSource.login(any));
          verify(mockAuthRemoteDataSource.getUser(any));
        },
      );

      test(
        'should return remote data when the call to remote data is successful',
        () async {
          // arrange
          successfulCall();

          // act
          final result = await repository.login(tUserCredentials);

          // assert
          verify(mockAuthRemoteDataSource.login(tUserCredentialsModel));
          verify(mockAuthRemoteDataSource.getUser(tAccessToken));
          expect(result, const Right(tAuthModel));
        },
      );

      test(
        'should cache the data locally when the call to remote data is successful',
        () async {
          // arrange
          successfulCall();

          // act
          await repository.login(tUserCredentials);

          // assert
          verify(mockAuthRemoteDataSource.login(tUserCredentialsModel));
          verify(mockAuthRemoteDataSource.getUser(tAccessToken));
          verify(mockAuthLocalDataSource.cacheAuth(tAuthModel));
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
          verify(mockAuthRemoteDataSource.login(tUserCredentialsModel));
          expect(result, Left(UserCredentialsMismatchFailure()));
        },
      );

      test(
        '''should return UserNotFoundFailure when the call
          to remote data throws a UserNotFoundException''',
        () async {
          // arrange
          when(mockAuthRemoteDataSource.login(any))
              .thenThrow(UserNotFoundException());

          // act
          final result = await repository.login(tUserCredentials);

          // assert
          verify(mockAuthRemoteDataSource.login(tUserCredentialsModel));
          expect(result, Left(UserNotFoundFailure()));
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
          verify(mockAuthRemoteDataSource.login(tUserCredentialsModel));
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

  group('getAuth', () {
    test(
      'should call the proper method to get the auth',
      () async {
        // arrange
        when(mockAuthLocalDataSource.getAuth())
            .thenAnswer((_) async => tAuthModel);

        // act
        final result = await repository.getAuth();

        // assert
        expect(result, const Right(tAuthModel));
        verify(mockAuthLocalDataSource.getAuth());
        verifyZeroInteractions(mockAuthRemoteDataSource);
      },
    );

    test(
      '''should return NotFoundFailure when the call 
      to local data throws a NotFoundException''',
      () async {
        // arrange
        when(mockAuthLocalDataSource.getAuth()).thenThrow(NotFoundException());

        // act
        final result = await repository.getAuth();

        // assert
        verify(mockAuthLocalDataSource.getAuth());
        expect(result, Left(NotFoundFailure()));
      },
    );

    test(
      '''should return CacheFailure when the call 
      to local data throws a CacheException''',
      () async {
        // arrange
        when(mockAuthLocalDataSource.getAuth()).thenThrow(CacheException());

        // act
        final result = await repository.getAuth();

        // assert
        verify(mockAuthLocalDataSource.getAuth());
        expect(result, Left(CacheFailure()));
      },
    );
  });
}
