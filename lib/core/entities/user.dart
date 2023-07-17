import 'package:equatable/equatable.dart';

class User extends Equatable {
  /// The [id] of the user.
  final String id;

  /// Th [firstName] of the user.
  final String firstName;

  /// The [lastName] of the user.
  final String lastName;

  /// The [identityCard] of the yser.
  final String identityCard;

  /// The [email] of the user.
  final String email;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.identityCard,
    required this.email,
  });

  @override
  List<Object> get props => [id, firstName, lastName, identityCard, email];
}
