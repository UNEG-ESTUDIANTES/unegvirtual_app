import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/models/access_token_model.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';

abstract class AuthRemoteDataSource {
  /// Calls the /v1/login endpoint.
  ///
  /// Throws an [UserCredentialsMismatchException] when the user is not found.
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<AccessTokenModel> login(UserCredentials userCredentials);
}
