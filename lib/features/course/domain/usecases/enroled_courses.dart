import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/courses_repository.dart';

class EnroledCourses implements UseCase<Courses, EnroledCoursesParams> {
  final CoursesRepository repository;

  EnroledCourses(this.repository);

  @override
  Future<Either<Failure, Courses>> call(EnroledCoursesParams params) async {
    return repository.enroledCourses(params.accessToken);
  }
}

class EnroledCoursesParams extends Equatable {
  final AccessToken accessToken;

  const EnroledCoursesParams({
    required this.accessToken,
  });

  @override
  List<Object> get props => throw UnimplementedError();
}
