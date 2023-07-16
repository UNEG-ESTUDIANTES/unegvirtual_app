import 'package:classroom_app/features/course/domain/entities/inscription.dart';
import 'package:classroom_app/features/course/domain/entities/new_course.dart';
import 'package:classroom_app/features/course/domain/repositories/courses_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/course_model.dart';
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
  Future<Either<Failure, CourseElement>> postCourse(NewCourse newCourse) async {
    if (await network.isConnected) {
      final remoteResult = await remote.postCourse(newCourse);
      return Right(remoteResult);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Inscription>> enrollStudent(
      Inscription inscription) async {
    if (await network.isConnected) {
      final remoteResult = await remote.enrollStudent(inscription);
      return Right(remoteResult);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Courses>> enroledCourses(String studentId) async {
    if (await network.isConnected) {
      final remoteResult = await remote.enroledCourses(studentId);
      return Right(remoteResult);
    }
    return Left(ServerFailure());
  }
}
