import 'package:equatable/equatable.dart';

class UnsavedUser extends Equatable {
  /// Th [firstName] of the user.
  final String firstName;

  /// The [lastName] of the user.
  final String lastName;

  /// The [identityCard] of the yser.
  final String identityCard;

  /// The [email] of the user.
  final String email;

  /// The [password] of the user.
  final String password;

  /// The [securityKey] to restore the password.
  final String securityKey;

  /// The user [type].
  final String type;

  const UnsavedUser({
    required this.firstName,
    required this.lastName,
    required this.identityCard,
    required this.email,
    required this.password,
    required this.securityKey,
    required this.type,
  });

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      identityCard,
      email,
      password,
      securityKey,
      type
    ];
  }
}
