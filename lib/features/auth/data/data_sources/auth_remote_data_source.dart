import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/env/env.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/models/access_token_model.dart';
import 'package:unegvirtual_app/core/models/user_model.dart';
import 'package:unegvirtual_app/features/auth/data/models/user_credentials_model.dart';

abstract class AuthRemoteDataSource {
  /// Calls the `/v1/login` endpoint.
  ///
  /// Throws an [UserCredentialsMismatchException] when the user credentials
  /// doesn't match.
  ///
  /// Throws an [UserNotFoundException] when the user is not found.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<AccessTokenModel> login(UserCredentialsModel userCredentials);

  /// Calls the `/v1/me` endpoint.
  ///
  /// Throws an [UserNotFoundException] when the user is not found.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<UserModel> getUser(AccessToken accessToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AccessTokenModel> login(UserCredentialsModel userCredentials) async {
    try {
      final response = await client.post(
        Uri.parse('${Env.appUrl}/v1/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(userCredentials.toJson()),
      );

      if (response.statusCode == 401) throw UserCredentialsMismatchException();

      if (response.statusCode == 404) throw UserNotFoundException();

      if (response.statusCode != 200) throw ServerException();

      return AccessTokenModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser(AccessToken accessToken) async {
    try {
      final response = await client.get(
        Uri.parse('${Env.appUrl}/v1/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken.token}'
        },
      );

      if (response.statusCode == 404) throw UserNotFoundException();

      if (response.statusCode != 200) throw ServerException();

      return UserModel.fromJson(json.decode(response.body)['user']);
    } on http.ClientException {
      throw ServerException();
    }
  }
}
