import 'package:classroom_app/core/error/failures.dart';

// Error messages.
const serverFailureMessage = 'Ha ocurrido un error en el servidor';
const cacheFailureMessage = 'Ha ocurrido un error en el caché';
const noInternetConnectionFailureMessage = 'No hay conexión a internet';
const notFoundMessage = 'No ha sido encontrado';
const userNotFoundFailureMessage = 'El usuario no existe';
const notAuthorizedFailureMessage = 'No está autorizado para ejecutar acción';
const notEnrolledFailureMessage = 'No está inscrito en el curso';
const emailTakenFailureMessage = 'El email ya está tomado';
const userCredentialsMismatchMessage = 'El email y contraseña no coinciden';
const unknownFailureMessage = 'Ha ocurrido un error desconocido';

class Utils {
  static String getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;

      case CacheFailure:
        return cacheFailureMessage;

      case NoInternetConnectionFailure:
        return noInternetConnectionFailureMessage;

      case NotFoundFailure:
        return notFoundMessage;

      case UserNotFoundFailure:
        return userNotFoundFailureMessage;

      case NotAuthorizedFailure:
        return notAuthorizedFailureMessage;

      case NotEnrolledFailure:
        return notEnrolledFailureMessage;

      case EmailTakenFailure:
        return emailTakenFailureMessage;

      case UserCredentialsMismatchFailure:
        return userCredentialsMismatchMessage;

      default:
        return 'Ha ocurrido un error desconocido';
    }
  }
}
