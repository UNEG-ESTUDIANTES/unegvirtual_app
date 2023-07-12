import 'package:equatable/equatable.dart';

class AccessToken extends Equatable {
  /// The user [token].
  final String token;

  const AccessToken(this.token);

  @override
  List<Object> get props => [token];
}
