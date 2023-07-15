import 'package:classroom_app/features/landing/domain/entities/course.dart';
import 'package:classroom_app/features/landing/domain/repositories/landing_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/landing_remote_datasource_impl.dart';

class LandingRepositoryImpl implements LandingRepository {
  final LandingRemoteDataSource remote;

  final NetworkInfo network;

  LandingRepositoryImpl({required this.remote, required this.network});

  @override
  Future<Either<Failure, Courses>> getCourses() async {
    if (await network.isConnected) {
      final remoteResult = await remote.getCourses();
      return Right(remoteResult);
    }
    return Left(ServerFailure());
  }
}
