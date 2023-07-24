import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/env/env.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/features/user/data/models/unsaved_user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the `/v1/signupUser` endpoint.
  ///
  /// Throws a [NotAuthorizedException] when the user is not authed.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<void> createUser({
    required AccessToken accessToken,
    required UnsavedUserModel user,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createUser({
    required AccessToken accessToken,
    required UnsavedUserModel user,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${Env.appUrl}/v1/signupUser'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken.token}'
        },
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 403) throw NotAuthorizedException();

      if (response.statusCode != 200) throw ServerException();
    } on http.ClientException {
      throw ServerException();
    }
  }
}
