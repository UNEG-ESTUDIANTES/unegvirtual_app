import 'package:dartz/dartz.dart';

import 'package:unegvirtual_app/core/entities/auth.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/providers/base_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';
import 'package:unegvirtual_app/features/auth/domain/entities/user_credentials.dart';
import 'package:unegvirtual_app/features/auth/domain/use_cases/get_auth.dart';
import 'package:unegvirtual_app/features/auth/domain/use_cases/login.dart';

class AuthProvider extends BaseProvider {
  final GetAuth _getAuth;
  final Login _login;

  AuthProvider({
    required GetAuth getAuth,
    required Login login,
  })  : _getAuth = getAuth,
        _login = login;

  Auth? _auth;

  /// The user [auth].
  Auth? get auth => _auth;

  /// Logs in with the [userCredentials].
  Future<void> login(UserCredentials userCredentials) async {
    state = Loading();

    _eitherLoadedOrErrorState(
      await _login(
        LoginParams(userCredentials: userCredentials),
      ),
    );
  }

  /// Gets the [Auth].
  Future<void> getAuth() async {
    state = Loading();

    _eitherLoadedOrErrorState(await _getAuth(NoParams()));
  }

  /// Changes the [state] according to [failureOrAuth].
  void _eitherLoadedOrErrorState(
    Either<Failure, Auth> failureOrAuth,
  ) {
    failureOrAuth.fold(
      (failure) => state = Error(message: Utils.getErrorMessage(failure)),
      (auth) {
        _auth = auth;
        state = const Loaded();
      },
    );
  }
}
