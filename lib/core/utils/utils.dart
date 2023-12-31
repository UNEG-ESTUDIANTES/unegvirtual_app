import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/error/failures.dart';

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

  /// Returns the [Failure] that matches the [exception] thrown.
  /// In case the [exception] doesn't match any then
  /// a [ServerFailure] will be returned.
  static Failure getFailure(Exception exception) {
    switch (exception.runtimeType) {
      case ServerException:
        return ServerFailure();

      case CacheException:
        return CacheFailure();

      case UserNotFoundException:
        return UserNotFoundFailure();

      case NotFoundException:
        return NotFoundFailure();

      case NoInternetConnectionException:
        return NoInternetConnectionFailure();

      case UserCredentialsMismatchException:
        return UserCredentialsMismatchFailure();

      case NotAuthorizedException:
        return NotAuthorizedFailure();

      case NotEnrolledException:
        return NotEnrolledFailure();

      case EmailTakenException:
        return EmailTakenFailure();

      default:
        return ServerFailure();
    }
  }
}
