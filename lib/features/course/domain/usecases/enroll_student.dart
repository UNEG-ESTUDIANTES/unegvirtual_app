import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:classroom_app/core/entities/access_token.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/inscription.dart';
import '../repositories/courses_repository.dart';

class EnrollStudent implements UseCase<Inscription, EnrollStudentParams> {
  final CoursesRepository repository;

  EnrollStudent(this.repository);

  @override
  Future<Either<Failure, Inscription>> call(
    EnrollStudentParams params,
  ) async {
    return repository.enrollStudent(params.inscription, params.accessToken);
  }
}

class EnrollStudentParams extends Equatable {
  final AccessToken accessToken;
  final Inscription inscription;

  const EnrollStudentParams({
    required this.accessToken,
    required this.inscription,
  });

  @override
  List<Object> get props => [accessToken, inscription];
}
