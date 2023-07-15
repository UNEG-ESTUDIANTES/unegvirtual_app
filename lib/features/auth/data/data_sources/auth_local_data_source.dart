import 'package:classroom_app/core/databases/db_provider.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/models/access_token_model.dart';

abstract class AuthLocalDataSource {
  /// Gets the cached [AccessTokenModel] which was stored the last time
  /// the user logged in.
  ///
  /// Throws [NotFoundException] if token is not found.
  /// Otherwise it throws [CacheException].
  Future<AccessTokenModel> getAccessToken();

  /// Stores the [accessToken] locally.
  Future<void> cacheAccessToken(AccessTokenModel accessToken);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DBProvider database;

  AuthLocalDataSourceImpl({required this.database});

  @override
  Future<void> cacheAccessToken(AccessTokenModel accessToken) async {
    // Removes last token.
    await database.removeToken();

    // Adds new token.
    await database.addToken(accessToken);
  }

  @override
  Future<AccessTokenModel> getAccessToken() async {
    final accessToken = await database.getToken();

    if (accessToken == null) throw NotFoundException();

    return accessToken;
  }
}
