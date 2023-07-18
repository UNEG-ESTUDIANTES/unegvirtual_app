import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/user/data/data_sources/user_local_data_source.dart';
import 'package:classroom_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:classroom_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser(AccessToken accessToken) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) return _getLocalCurrentUser();

    try {
      final user = await remoteDataSource.getCurrentUser(accessToken);

      await localDataSource.cacheUser(user);

      return Right(user);
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    } on ServerException {
      return _getLocalCurrentUser();
    }
  }

  /// Gets the current user stored locally.
  Future<Either<Failure, User>> _getLocalCurrentUser() async {
    try {
      final user = await localDataSource.getCurrentUser();

      return Right(user);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
