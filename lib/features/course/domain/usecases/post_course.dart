import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/course.dart';
import 'package:unegvirtual_app/features/course/domain/entities/new_course.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/courses_repository.dart';

class PostCourse implements UseCase<Course, PostCourseParams> {
  final CoursesRepository repository;

  PostCourse(this.repository);

  @override
  Future<Either<Failure, Course>> call(PostCourseParams params) async {
    return repository.postCourse(
      newCourse: params.newCourse,
      accessToken: params.accessToken,
    );
  }
}

class PostCourseParams extends Equatable {
  final AccessToken accessToken;
  final NewCourse newCourse;

  const PostCourseParams({
    required this.accessToken,
    required this.newCourse,
  });

  @override
  List<Object> get props => [accessToken, newCourse];
}
