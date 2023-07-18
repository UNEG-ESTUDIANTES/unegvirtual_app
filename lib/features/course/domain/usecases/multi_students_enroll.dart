import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:classroom_app/core/entities/access_token.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/multi_enroll.dart';
import '../repositories/courses_repository.dart';

class MultiStudentsEnroll implements UseCase<void, MultiStudentsEnrollParams> {
  final CoursesRepository repository;

  MultiStudentsEnroll(this.repository);

  @override
  Future<Either<Failure, void>> call(
    MultiStudentsEnrollParams params,
  ) async {
    return repository.multiStudentsEnroll(
      params.multiEnroll,
      params.accessToken,
    );
  }
}

class MultiStudentsEnrollParams extends Equatable {
  final AccessToken accessToken;
  final MultiEnroll multiEnroll;

  const MultiStudentsEnrollParams({
    required this.accessToken,
    required this.multiEnroll,
  });

  @override
  List<Object> get props => [accessToken, multiEnroll];
}
