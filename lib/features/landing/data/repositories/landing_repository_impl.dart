import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/courses.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/features/landing/domain/repositories/landing_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/landing_remote_datasource_impl.dart';

class LandingRepositoryImpl implements LandingRepository {
  final LandingRemoteDataSource remote;

  final NetworkInfo network;

  LandingRepositoryImpl({required this.remote, required this.network});

  @override
  Future<Either<Failure, Courses>> getCourses() async {
    final isConnected = await network.isConnected;

    if (!isConnected) return Left(ServerFailure());

    try {
      return Right(await remote.getCourses());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
