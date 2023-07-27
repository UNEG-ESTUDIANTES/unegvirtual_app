import 'package:dartz/dartz.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart';

abstract class UserRepository {
  /// Creates a new user.
  Future<Either<Failure, void>> createUser({
    required AccessToken accessToken,
    required UnsavedUser unsavedUser,
  });
}
