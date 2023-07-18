import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/multi_enroll.dart';
import '../repositories/courses_repository.dart';

class MultiStudentsEnroll implements UseCase<void, MultiEnroll> {
  final CoursesRepository repository;

  MultiStudentsEnroll(this.repository);

  @override
  Future<Either<Failure, void>> call(MultiEnroll multiEnroll) async {
    return await repository.multiStudentsEnroll(multiEnroll);
  }
}
