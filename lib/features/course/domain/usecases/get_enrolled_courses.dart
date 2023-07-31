import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/courses_repository.dart';

class GetEnrolledCourses implements UseCase<Courses, GetEnrolledCoursesParams> {
  final CoursesRepository repository;

  GetEnrolledCourses(this.repository);

  @override
  Future<Either<Failure, Courses>> call(GetEnrolledCoursesParams params) async {
    return repository.getEnrolledCourses(params.accessToken);
  }
}

class GetEnrolledCoursesParams extends Equatable {
  final AccessToken accessToken;

  const GetEnrolledCoursesParams({
    required this.accessToken,
  });

  @override
  List<Object> get props => [accessToken];
}
