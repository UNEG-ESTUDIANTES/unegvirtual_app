import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/models/access_token_model.dart';
import 'package:classroom_app/features/auth/data/models/user_credentials_model.dart';

abstract class AuthRemoteDataSource {
  /// Calls the /v1/login endpoint.
  ///
  /// Throws an [UserCredentialsMismatchException] when the user credentials
  /// doesn't match.
  ///
  /// Throws an [NotFoundException] when the user is not found.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<AccessTokenModel> login(UserCredentialsModel userCredentials);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AccessTokenModel> login(UserCredentialsModel userCredentials) async {
    try {
      final response = await client.post(
        Uri.http(
          '0.0.0.0:3000',
          '/v1/login',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: userCredentials.toJson(),
      );

      if (response.statusCode == 401) throw UserCredentialsMismatchException();

      if (response.statusCode != 200) throw ServerException();

      return AccessTokenModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw ServerException();
    }
  }
}
