import 'package:unegvirtual_app/core/entities/access_token.dart';

class AccessTokenModel extends AccessToken {
  const AccessTokenModel(super.token);

  /// Returns an [AccessTokenModel] from [json].
  factory AccessTokenModel.fromJson(Map<String, dynamic> json) {
    return AccessTokenModel(json['token']);
  }

  /// Returns an [AccessTokenModel] from the [accessToken].
  factory AccessTokenModel.fromEntity(AccessToken accessToken) {
    return AccessTokenModel(accessToken.token);
  }

  /// Converts the [AccessToken] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
