import 'package:dartz/dartz.dart';

import 'package:unegvirtual_app/core/entities/auth.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/features/auth/domain/repository/auth_repository.dart';

class GetAuth implements UseCase<Auth, NoParams> {
  final AuthRepository repository;

  GetAuth(this.repository);

  @override
  Future<Either<Failure, Auth>> call(NoParams params) {
    return repository.getAuth();
  }
}
