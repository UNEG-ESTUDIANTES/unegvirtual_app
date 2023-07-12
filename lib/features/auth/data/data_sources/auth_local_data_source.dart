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
  ///
  /// Throws [NotFoundException] if token is not found.
  /// Otherwise it throws [CacheException].
  Future<void> cacheAccessToken(AccessTokenModel accessToken);
}
