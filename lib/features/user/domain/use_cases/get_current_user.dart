import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/user/domain/repositories/user_repository.dart';

class GetCurrentUser implements UseCase<User, GetCurrentUserParams> {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, User>> call(GetCurrentUserParams params) {
    return repository.getCurrentUser(params.accessToken);
  }
}

class GetCurrentUserParams extends Equatable {
  final AccessToken accessToken;

  const GetCurrentUserParams({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}
