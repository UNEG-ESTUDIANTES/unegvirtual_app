import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/auth.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';

abstract class AuthRepository {
  /// Logs in the with the [userCredentials].
  Future<Either<Failure, Auth>> login(UserCredentials userCredentials);

  /// Gets the [Auth] stored.
  Future<Either<Failure, Auth>> getAuth();
}
