import 'package:dartz/dartz.dart';

import 'package:unegvirtual_app/features/course/domain/repositories/courses_repository.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';

class GetCourses implements UseCase<Courses, NoParams> {
  final CoursesRepository repository;

  GetCourses(this.repository);

  @override
  Future<Either<Failure, Courses>> call(NoParams noParams) async {
    return await repository.getCourses();
  }
}
