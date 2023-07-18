import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/features/course/domain/entities/new_course.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/courses_repository.dart';

class PostCourse implements UseCase<Course, NewCourse> {
  final CoursesRepository repository;

  PostCourse(this.repository);

  @override
  Future<Either<Failure, Course>> call(NewCourse newCourse) async {
    return await repository.postCourse(newCourse);
  }
}
