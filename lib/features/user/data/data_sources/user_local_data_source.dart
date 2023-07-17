import 'package:classroom_app/core/models/user_model.dart';

abstract class UserLocalDataSource {
  /// Gets the cached [UserModel] which was stored the last time
  /// the user loaded its profile.
  ///
  /// Throws [NotFoundException] if user is not found.
  ///
  /// Otherwise it throws [CacheException].
  Future<UserModel> getCurrentUser();

  /// Stores the [user] locally.
  Future<void> cacheUser(UserModel user);
}
