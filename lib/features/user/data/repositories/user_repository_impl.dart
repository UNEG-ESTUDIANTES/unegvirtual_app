import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/core/utils/utils.dart';
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
    required UnsavedUser unsavedUser,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) return Left(NoInternetConnectionFailure());

    try {
      await remoteDataSource.createUser(
        accessToken: accessToken,
        unsavedUser: UnsavedUserModel.fromEntity(unsavedUser),
      );

      return const Right(null);
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }
}
