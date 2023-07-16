import 'package:classroom_app/features/course/domain/entities/new_course.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/course_model.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/courses_repository.dart';

class PostCourse implements UseCase<CourseElement, NewCourse> {
  final CoursesRepository repository;

  PostCourse(this.repository);

  @override
  Future<Either<Failure, CourseElement>> call(NewCourse newCourse) async {
    return await repository.postCourse(newCourse);
  }
}
