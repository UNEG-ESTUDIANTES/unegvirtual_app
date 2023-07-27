import 'package:dartz/dartz.dart';

import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/core/entities/courses.dart';

import '../../../../core/error/failures.dart';
import '../repositories/landing_repository.dart';

class GetCourses implements UseCase<Courses, NoParams> {
  final LandingRepository repository;

  GetCourses(this.repository);

  @override
  Future<Either<Failure, Courses>> call(NoParams noParams) async {
    return await repository.getCourses();
  }
}
