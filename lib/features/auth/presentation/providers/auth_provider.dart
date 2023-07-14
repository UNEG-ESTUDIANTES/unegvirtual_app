import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';
import 'package:classroom_app/features/auth/domain/use_cases/get_access_token.dart';
import 'package:classroom_app/features/auth/domain/use_cases/login.dart';

// Error messages.
const userCredentialsMismatchMessage = 'El email y contraseña no coinciden';
const notFoundMessage = 'No ha sido encontrado';
const serverFailureMessage = 'Ha ocurrido un error en el servidor';
const cacheFailureMessage = 'Ha ocurrido un error en el caché';

class AuthProvider extends ChangeNotifier {
  PageState _state = Empty();
  final GetAccessToken getAccessTokenUseCase;
  final Login loginUseCase;

  PageState get state => _state;

  set state(PageState pageState) {
    _state = pageState;
    notifyListeners();
  }

  AuthProvider({
    required this.getAccessTokenUseCase,
    required this.loginUseCase,
  });

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
      (failure) => state = Error(message: _getErrorMessage(failure)),
      (accessToken) => state = Loaded(value: accessToken),
    );
  }

  /// Gets the error message according to the [failure].
  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case UserCredentialsMismatchFailure:
        return userCredentialsMismatchMessage;

      case NotFoundFailure:
        return notFoundMessage;

      case ServerFailure:
        return serverFailureMessage;

      case CacheFailure:
        return cacheFailureMessage;

      default:
        return 'Ha ocurrido un error desconocido';
    }
  }
}
