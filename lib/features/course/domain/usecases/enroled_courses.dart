import 'package:dartz/dartz.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/courses_repository.dart';

class EnroledCourses implements UseCase<Courses, String> {
  final CoursesRepository repository;

  EnroledCourses(this.repository);

  @override
  Future<Either<Failure, Courses>> call(String studentId) async {
    return await repository.enroledCourses(studentId);
  }
}
