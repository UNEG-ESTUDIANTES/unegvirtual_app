import 'package:equatable/equatable.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/user.dart';

class Auth extends Equatable {
  /// The user [accessToken].
  final AccessToken accessToken;

  /// The authed [user].
  final User user;

  const Auth({
    required this.accessToken,
    required this.user,
  });

  @override
  List<Object> get props => [accessToken, user];
}
