import 'package:classroom_app/core/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.identityCard,
    required super.email,
  });

  /// Returns an [UserModel] from [json].
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      identityCard: json['ci'],
      lastName: json['lastName'],
    );
  }

  /// Returns an [UserModel] from the [user].
  factory UserModel.fromEntity(User user) {
    return UserModel(
      email: user.email,
      firstName: user.firstName,
      id: user.id,
      identityCard: user.identityCard,
      lastName: user.lastName,
    );
  }

  /// Converts the [UserModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "firstName": firstName,
      "lastName": lastName,
      "ci": identityCard,
      "email": email,
    };
  }
}
