import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/env/env.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the `/v1/me` endpoint.
  ///
  /// Throws an [UserNotFoundException] when the user is not found.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<UserModel> getCurrentUser(AccessToken accessToken);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getCurrentUser(AccessToken accessToken) async {
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
