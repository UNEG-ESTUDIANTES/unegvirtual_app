import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart';

class UnsavedUserModel extends UnsavedUser {
  const UnsavedUserModel({
    required super.firstName,
    required super.lastName,
    required super.identityCard,
    required super.email,
    required super.password,
    required super.securityKey,
    required super.type,
  });

  /// Returns an [UnsavedUserModel] from the [user].
  factory UnsavedUserModel.fromEntity(UnsavedUser user) {
    return UnsavedUserModel(
      email: user.email,
      firstName: user.firstName,
      identityCard: user.identityCard,
      lastName: user.lastName,
      password: user.password,
      securityKey: user.securityKey,
      type: user.type,
    );
  }

  /// Converts the [UnsavedUserModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "ci": identityCard,
      "email": email,
      "password": password,
      "securityKey": securityKey,
      "type": type,
    };
  }
}
