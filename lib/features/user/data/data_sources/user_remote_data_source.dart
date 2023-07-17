import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the `/v1/me` endpoint.
  ///
  /// Throws an [UserNotFoundException] when the user is not found.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<UserModel> getCurrentUser(AccessToken accessToken);
}
