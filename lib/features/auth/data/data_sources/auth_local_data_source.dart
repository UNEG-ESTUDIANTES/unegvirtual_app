import 'package:unegvirtual_app/core/databases/db_provider.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/models/auth_model.dart';

abstract class AuthLocalDataSource {
  /// Gets the cached [AuthModel] which was stored the last time
  /// the user logged in.
  ///
  /// Throws [NotFoundException] if token is not found.
  /// Otherwise it throws [CacheException].
  Future<AuthModel> getAuth();

  /// Stores the [auth] locally.
  Future<void> cacheAuth(AuthModel auth);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DBProvider database;

  AuthLocalDataSourceImpl({required this.database});

  @override
  Future<void> cacheAuth(AuthModel auth) async {
    // Removes last token.
    await database.removeAuth();

    // Adds new token.
    await database.addAuth(auth);
  }

  @override
  Future<AuthModel> getAuth() async {
    final auth = await database.getAuth();

    if (auth == null) throw NotFoundException();

    return auth;
  }
}
