import 'package:classroom_app/core/databases/db_provider.dart';
import 'package:classroom_app/core/error/exceptions.dart';
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

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final DBProvider database;

  UserLocalDataSourceImpl({required this.database});

  @override
  Future<void> cacheUser(UserModel user) async {
    // Removes last user profile.
    await database.removeUserProfile();

    // Adds new user profile.
    await database.addUserProfile(user);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final user = await database.getUserProfile();

    if (user == null) throw NotFoundException();

    return user;
  }
}
