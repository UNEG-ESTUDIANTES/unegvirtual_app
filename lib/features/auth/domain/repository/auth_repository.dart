import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';

abstract class AuthRepository {
  /// Logs in the with the [userCredentials].
  Future<Either<Failure, AccessToken>> login(UserCredentials userCredentials);

  /// Gets the [AccessToken] stored.
  Future<Either<Failure, AccessToken>> getAccessToken();
}
