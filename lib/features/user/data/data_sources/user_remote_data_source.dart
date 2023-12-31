import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/env/env.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/features/user/data/models/unsaved_user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the `/v1/signupUser` endpoint.
  ///
  /// Throws a [NotAuthorizedException] when the user is not authed.
  ///
  /// Throws an [EmailTakenException] when the email is taken.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<void> createUser({
    required AccessToken accessToken,
    required UnsavedUserModel unsavedUser,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createUser({
    required AccessToken accessToken,
    required UnsavedUserModel unsavedUser,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${Env.appUrl}/v1/signupUser'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken.token}'
        },
        body: json.encode(unsavedUser.toJson()),
      );

      if (response.statusCode == 401) throw NotAuthorizedException();

      if (response.statusCode == 409) throw EmailTakenException();

      if (response.statusCode != 200) throw ServerException();
    } on http.ClientException {
      throw ServerException();
    }
  }
}
