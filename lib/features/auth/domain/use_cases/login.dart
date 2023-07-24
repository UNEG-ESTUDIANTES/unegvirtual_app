import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:classroom_app/core/entities/auth.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';
import 'package:classroom_app/features/auth/domain/repository/auth_repository.dart';

class Login implements UseCase<Auth, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, Auth>> call(LoginParams params) {
    return repository.login(params.userCredentials);
  }
}

class LoginParams extends Equatable {
  final UserCredentials userCredentials;

  const LoginParams({required this.userCredentials});

  @override
  List<Object> get props => [userCredentials];
}
