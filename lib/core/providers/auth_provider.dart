import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/providers/base_provider.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/core/utils/utils.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';
import 'package:classroom_app/features/auth/domain/use_cases/get_auth.dart';
import 'package:classroom_app/features/auth/domain/use_cases/login.dart';

class AuthProvider extends BaseProvider {
  final GetAccessToken getAccessTokenUseCase;
  final Login loginUseCase;

  AuthProvider({
    required this.getAccessTokenUseCase,
    required this.loginUseCase,
  });

  AccessToken? _accessToken;

  /// The user [accessToken].
  AccessToken? get accessToken => _accessToken;

  /// Logs in with the [userCredentials].
  Future<void> login(UserCredentials userCredentials) async {
    state = Loading();

    _eitherLoadedOrErrorState(
      await loginUseCase(
        LoginParams(userCredentials: userCredentials),
      ),
    );
  }

  /// Gets the [AccessToken].
  Future<void> getToken() async {
    state = Loading();

    _eitherLoadedOrErrorState(await getAccessTokenUseCase(NoParams()));
  }

  /// Changes the [state] according to [failureOrAccessToken].
  void _eitherLoadedOrErrorState(
    Either<Failure, AccessToken> failureOrAccessToken,
  ) {
    failureOrAccessToken.fold(
      (failure) => state = Error(message: Utils.getErrorMessage(failure)),
      (accessToken) {
        _accessToken = accessToken;
        state = const Loaded();
      },
    );
  }
}
