import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/auth/domain/repository/auth_repository.dart';

class GetAccessToken implements UseCase<AccessToken, NoParams> {
  final AuthRepository repository;

  GetAccessToken(this.repository);

  @override
  Future<Either<Failure, AccessToken>> call(NoParams params) {
    return repository.getAccessToken();
  }
}
