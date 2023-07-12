import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';

class UserCredentialsModel extends UserCredentials {
  const UserCredentialsModel({required super.email, required super.password});

  /// Converts the [UserCredentials] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
