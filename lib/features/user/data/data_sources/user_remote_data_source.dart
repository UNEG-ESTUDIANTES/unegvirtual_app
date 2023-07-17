import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/models/access_token_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the `/v1/me` endpoint.
  ///
  /// Throws an [UserNotFoundException] when the user is not found.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<User> getCurrentUser(AccessTokenModel accessToken);
}
