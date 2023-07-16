import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/inscription.dart';
import '../repositories/courses_repository.dart';

class EnrollStudent implements UseCase<Inscription, Inscription> {
  final CoursesRepository repository;

  EnrollStudent(this.repository);

  @override
  Future<Either<Failure, Inscription>> call(Inscription inscription) async {
    return await repository.enrollStudent(inscription);
  }
}
