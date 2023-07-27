import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart';
import 'package:unegvirtual_app/features/user/domain/repositories/user_repository.dart';

class CreateUser implements UseCase<void, CreateUserParams> {
  final UserRepository repository;

  CreateUser(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateUserParams params) {
    return repository.createUser(
      accessToken: params.accessToken,
      unsavedUser: params.unsavedUser,
    );
  }
}

class CreateUserParams extends Equatable {
  final AccessToken accessToken;
  final UnsavedUser unsavedUser;

  const CreateUserParams({
    required this.accessToken,
    required this.unsavedUser,
  });

  @override
  List<Object> get props => [accessToken, unsavedUser];
}
