import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/network/network_info.dart';
import 'package:unegvirtual_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:unegvirtual_app/features/user/data/models/unsaved_user_model.dart';
import 'package:unegvirtual_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart';

@GenerateNiceMocks([
  MockSpec<UserRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'user_repository_impl_test.mocks.dart';

void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late UserRepositoryImpl repository;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = UserRepositoryImpl(
      remoteDataSource: mockUserRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tUnsavedUser = UnsavedUser(
    password: 'test',
    securityKey: 'test',
    type: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  final tUnsavedUserModel = UnsavedUserModel.fromEntity(tUnsavedUser);

  const tAccessToken = AccessToken('test');

  group('createUser', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.createUser(
          accessToken: tAccessToken,
          unsavedUser: tUnsavedUser,
        );

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      void successfulCall() {
        when(mockUserRemoteDataSource.createUser(
          accessToken: anyNamed('accessToken'),
          unsavedUser: anyNamed('unsavedUser'),
        )).thenAnswer((_) async => {});
      }

      void unsuccessfulCall(Exception exception) {
        when(mockUserRemoteDataSource.createUser(
          accessToken: anyNamed('accessToken'),
          unsavedUser: anyNamed('unsavedUser'),
        )).thenThrow(exception);
      }

      test(
        'should call the proper method to create the user',
        () async {
          // arrange
          successfulCall();

          // act
          await repository.createUser(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUser,
          );

          // assert
          verify(
            mockUserRemoteDataSource.createUser(
              accessToken: anyNamed('accessToken'),
              unsavedUser: anyNamed('unsavedUser'),
            ),
          );
        },
      );

      test(
        'should return remote data when the call to remote data is successful',
        () async {
          // arrange
          successfulCall();

          // act
          final result = await repository.createUser(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUser,
          );

          // assert
          verify(
            mockUserRemoteDataSource.createUser(
              accessToken: tAccessToken,
              unsavedUser: tUnsavedUserModel,
            ),
          );

          expect(result, const Right(null));
        },
      );

      test(
        '''should return NotAuthorizedFailure when the call
        to remote data throws a NotAuthorizedException''',
        () async {
          // arrange
          unsuccessfulCall(NotAuthorizedException());

          // act
          final result = await repository.createUser(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUser,
          );

          // assert
          verify(
            mockUserRemoteDataSource.createUser(
              accessToken: tAccessToken,
              unsavedUser: tUnsavedUserModel,
            ),
          );

          expect(result, Left(NotAuthorizedFailure()));
        },
      );

      test(
        '''should return EmailTakenFailure when the call
        to remote data throws a EmailTakenException''',
        () async {
          // arrange
          unsuccessfulCall(EmailTakenException());

          // act
          final result = await repository.createUser(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUser,
          );

          // assert
          verify(
            mockUserRemoteDataSource.createUser(
              accessToken: tAccessToken,
              unsavedUser: tUnsavedUserModel,
            ),
          );

          expect(result, Left(EmailTakenFailure()));
        },
      );

      test(
        '''should return ServerFailure when the call
        to remote data throws a ServerException''',
        () async {
          // arrange
          unsuccessfulCall(ServerException());

          // act
          final result = await repository.createUser(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUser,
          );

          // assert
          verify(
            mockUserRemoteDataSource.createUser(
              accessToken: tAccessToken,
              unsavedUser: tUnsavedUserModel,
            ),
          );

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
          final result = await repository.createUser(
            accessToken: tAccessToken,
            unsavedUser: tUnsavedUser,
          );

          // assert
          verifyZeroInteractions(mockUserRemoteDataSource);
          expect(result, Left(NoInternetConnectionFailure()));
        },
      );
    });
  });
}
