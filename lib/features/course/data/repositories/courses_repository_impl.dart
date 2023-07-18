import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/features/course/data/models/new_course_model.dart';
import 'package:classroom_app/features/course/domain/entities/inscription.dart';
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart';
import 'package:classroom_app/features/course/domain/entities/new_course.dart';
import 'package:classroom_app/features/course/domain/repositories/courses_repository.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/courses_remote_datasource.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource remote;

  final NetworkInfo network;

  CoursesRepositoryImpl({required this.remote, required this.network});

  @override
  Future<Either<Failure, Courses>> getCourses() async {
    if (await network.isConnected) {
      final remoteResult = await remote.getCourses();
      return Right(remoteResult);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Course>> postCourse({
    required NewCourse newCourse,
    required AccessToken accessToken,
  }) async {
    if (await network.isConnected) {
      final remoteResult = await remote.postCourse(
        newCourse: NewCourseModel.fromEntity(newCourse),
        accessToken: accessToken,
      );

      return Right(remoteResult);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Inscription>> enrollStudent({
    required Inscription inscription,
    required AccessToken accessToken,
  }) async {
    if (await network.isConnected) {
      final remoteResult = await remote.enrollStudent(
        inscription: inscription,
        accessToken: accessToken,
      );

      return Right(remoteResult);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Courses>> enroledCourses(
    AccessToken accessToken,
  ) async {
    if (await network.isConnected) {
      final remoteResult = await remote.enroledCourses(accessToken);
      return Right(remoteResult);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> multiStudentsEnroll({
    required MultiEnroll multiEnroll,
    required AccessToken accessToken,
  }) async {
    if (await network.isConnected) {
      await remote.multiStudentEnroll(
        multiEnroll: multiEnroll,
        accessToken: accessToken,
      );

      return const Right(true);
    }
    return Left(ServerFailure());
  }
}
