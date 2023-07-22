import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/user/domain/entities/unsaved_user.dart';
import 'package:classroom_app/features/user/domain/repositories/user_repository.dart';

class CreateUser implements UseCase<void, CreateCourseParams> {
  final UserRepository repository;

  CreateUser(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateCourseParams params) {
    return repository.createUser(
      accessToken: params.accessToken,
      user: params.user,
    );
  }
}

class CreateCourseParams extends Equatable {
  final AccessToken accessToken;
  final UnsavedUser user;

  const CreateCourseParams({
    required this.accessToken,
    required this.user,
  });

  @override
  List<Object> get props => [accessToken, user];
}
