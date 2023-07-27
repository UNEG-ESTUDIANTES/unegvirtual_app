import 'package:unegvirtual_app/features/auth/domain/entities/user_credentials.dart';

class UserCredentialsModel extends UserCredentials {
  const UserCredentialsModel({required super.email, required super.password});

  /// Returns an [UserCredentialsModel] from the [userCredentials].
  factory UserCredentialsModel.fromEntity(UserCredentials userCredentials) {
    return UserCredentialsModel(
      email: userCredentials.email,
      password: userCredentials.password,
    );
  }

  /// Converts the [UserCredentials] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
