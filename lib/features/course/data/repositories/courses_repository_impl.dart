import 'package:dartz/dartz.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/course.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';
import 'package:unegvirtual_app/features/course/data/models/inscription_model.dart';
import 'package:unegvirtual_app/features/course/data/models/multi_enroll_model.dart';
import 'package:unegvirtual_app/features/course/data/models/new_course_model.dart';
import 'package:unegvirtual_app/features/course/domain/entities/inscription.dart';
import 'package:unegvirtual_app/features/course/domain/entities/multi_enroll.dart';
import 'package:unegvirtual_app/features/course/domain/entities/new_course.dart';
import 'package:unegvirtual_app/features/course/domain/repositories/courses_repository.dart';

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
    final isConnected = await network.isConnected;

    if (!isConnected) return Left(NoInternetConnectionFailure());

    try {
      return Right(await remote.getCourses());
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Course>> postCourse({
    required NewCourse newCourse,
    required AccessToken accessToken,
  }) async {
    final isConnected = await network.isConnected;

    if (!isConnected) return Left(ServerFailure());

    try {
      final remoteResult = await remote.postCourse(
        newCourse: NewCourseModel.fromEntity(newCourse),
        accessToken: accessToken,
      );

      return Right(remoteResult);
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Inscription>> enrollStudent({
    required Inscription inscription,
    required AccessToken accessToken,
  }) async {
    final isConnected = await network.isConnected;

    if (!isConnected) return Left(ServerFailure());

    try {
      final remoteResult = await remote.enrollStudent(
        inscription: InscriptionModel.fromEntity(inscription),
        accessToken: accessToken,
      );

      return Right(remoteResult);
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Courses>> getEnrolledCourses(
    AccessToken accessToken,
  ) async {
    final isConnected = await network.isConnected;

    if (!isConnected) return Left(NoInternetConnectionFailure());

    try {
      final remoteResult = await remote.getEnrolledCourses(accessToken);
      return Right(remoteResult);
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }

  @override
  Future<Either<Failure, bool>> multiStudentsEnroll({
    required MultiEnroll multiEnroll,
    required AccessToken accessToken,
  }) async {
    final isConnected = await network.isConnected;

    if (!isConnected) return Left(ServerFailure());

    try {
      await remote.multiStudentEnroll(
        multiEnroll: MultiEnrollModel.fromEntity(multiEnroll),
        accessToken: accessToken,
      );

      return const Right(true);
    } on Exception catch (exception) {
      return Left(Utils.getFailure(exception));
    }
  }
}
