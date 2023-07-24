import 'package:classroom_app/core/databases/db_provider.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/models/access_token_model.dart';
import 'package:classroom_app/core/models/auth_model.dart';

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

// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   final DBProvider database;

//   AuthLocalDataSourceImpl({required this.database});

//   @override
//   Future<void> cacheAccessToken(AccessTokenModel accessToken) async {
//     // Removes last token.
//     await database.removeToken();

//     // Adds new token.
//     await database.addToken(accessToken);
//   }

//   @override
//   Future<AccessTokenModel> getAccessToken() async {
//     final accessToken = await database.getToken();

//     if (accessToken == null) throw NotFoundException();

//     return accessToken;
//   }
// }
