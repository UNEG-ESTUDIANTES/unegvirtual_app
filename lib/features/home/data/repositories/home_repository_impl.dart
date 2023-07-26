import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/utils/utils.dart';
import 'package:classroom_app/features/home/data/datasource/home_remote_datasource.dart';
import 'package:classroom_app/features/home/domain/repositories/home_repository.dart';

import '../../../../core/entities/access_token.dart';
import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  final NetworkInfo network;

  HomeRepositoryImpl({required this.remote, required this.network});

  @override
  Future<Either<Failure, Courses>> enroledCourses(
    AccessToken accessToken,
  ) async {
    final isConnected = await network.isConnected;

    if (!isConnected) return Left(ServerFailure());

    try {
      final remoteResult = await remote.enroledCourses(accessToken);
      return Right(remoteResult);
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }
}
