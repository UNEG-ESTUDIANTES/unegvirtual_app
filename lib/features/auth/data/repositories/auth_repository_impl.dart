import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:classroom_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';
import 'package:classroom_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AccessToken>> login(
    UserCredentials userCredentials,
  ) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) return Left(NoInternetConnectionFailure());

    try {
      final accessToken = await remoteDataSource.login(userCredentials);
      await localDataSource.cacheAccessToken(accessToken);

      return Right(accessToken);
    } on UserCredentialsMismatchException {
      return Left(UserCredentialsMismatchFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccessToken>> getAccessToken() async {
    try {
      return Right(await localDataSource.getAccessToken());
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
