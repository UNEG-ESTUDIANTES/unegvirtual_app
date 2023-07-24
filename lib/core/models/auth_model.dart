import 'package:classroom_app/core/entities/auth.dart';
import 'package:classroom_app/core/models/access_token_model.dart';
import 'package:classroom_app/core/models/user_model.dart';

class AuthModel extends Auth {
  const AuthModel({required super.accessToken, required super.user});

  /// Returns an [AuthModel] from [json].
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: AccessTokenModel.fromJson(json['accessToken']),
      user: UserModel.fromJson(json['user']),
    );
  }

  /// Converts the [AuthModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken.toJson(),
      'user': user.toJson(),
    };
  }

  @override
  AccessTokenModel get accessToken {
    return AccessTokenModel.fromEntity(super.accessToken);
  }

  @override
  UserModel get user {
    return UserModel.fromEntity(super.user);
  }
}
