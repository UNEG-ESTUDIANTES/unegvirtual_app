import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/auth.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/models/auth_model.dart';
import 'package:classroom_app/core/network/network_info.dart';
import 'package:classroom_app/core/utils/utils.dart';
import 'package:classroom_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:classroom_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:classroom_app/features/auth/data/models/user_credentials_model.dart';
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
  Future<Either<Failure, Auth>> login(
    UserCredentials userCredentials,
  ) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) return Left(NoInternetConnectionFailure());

    try {
      final accessToken = await remoteDataSource.login(
        UserCredentialsModel.fromEntity(userCredentials),
      );

      final user = await remoteDataSource.getUser(accessToken);

      final auth = AuthModel(
        accessToken: accessToken,
        user: user,
      );

      // Store the auth.
      await localDataSource.cacheAuth(auth);

      return Right(auth);
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Auth>> getAuth() async {
    try {
      return Right(await localDataSource.getAuth());
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }
}
