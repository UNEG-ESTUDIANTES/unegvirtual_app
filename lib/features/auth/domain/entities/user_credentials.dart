import 'package:equatable/equatable.dart';

class UserCredentials extends Equatable {
  /// The user [email].
  final String email;

  /// The user [password].
  final String password;

  const UserCredentials({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
