import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:classroom_app/features/user/data/models/unsaved_user_model.dart';
import 'package:classroom_app/features/user/domain/entities/unsaved_user.dart';
import 'package:classroom_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> createUser({
    required AccessToken accessToken,
    required UnsavedUser user,
  }) async {
    try {
      await remoteDataSource.createUser(
        accessToken: accessToken,
        user: UnsavedUserModel.fromEntity(user),
      );

      return const Right(null);
    } on NotAuthorizedException {
      return Left(NotAuthorizedFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
