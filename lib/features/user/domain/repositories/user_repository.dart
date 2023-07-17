import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/error/failures.dart';

abstract class UserRepository {
  /// Gets the information of the current user.
  Future<Either<Failure, User>> getCurrentUser(AccessToken accessToken);
}
