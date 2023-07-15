import 'package:classroom_app/features/landing/domain/entities/course.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';

import '../repositories/landing_repository.dart';

class GetCourses implements UseCase<Courses, NoParams> {
  final LandingRepository repository;

  GetCourses(this.repository);

  @override
  Future<Either<Failure, Courses>> call(NoParams noParams) async {
    return await repository.getCourses();
  }
}
