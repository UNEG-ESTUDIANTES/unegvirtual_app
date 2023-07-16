import 'package:classroom_app/core/error/failures.dart';

// Error messages.
const userCredentialsMismatchMessage = 'El email y contraseña no coinciden';
const notFoundMessage = 'No ha sido encontrado';
const serverFailureMessage = 'Ha ocurrido un error en el servidor';
const cacheFailureMessage = 'Ha ocurrido un error en el caché';
const unknownFailureMessage = 'Ha ocurrido un error desconocido';

class Utils {
  static String getErrorMessage(Failure failure) {
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
