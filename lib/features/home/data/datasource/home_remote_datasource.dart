import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:unegvirtual_app/core/models/courses_model.dart';
import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import '../../../../core/env/env.dart';

abstract class HomeRemoteDataSource {
  /// Calls the `/v1/enrolledCourses` endpoint.
  ///
  /// Throws a [NotEnrolledException] when the user is not enroled
  /// to any course.
  ///
  /// Throws a [ServerException] for all other error codes.
  Future<CoursesModel> enroledCourses(AccessToken accessToken);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<CoursesModel> enroledCourses(AccessToken accessToken) async {
    try {
      final response = await client.get(
        Uri.parse('${Env.appUrl}/v1/enrolledCourses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken.token}',
        },
      );

      if (response.statusCode == 404) throw NotEnrolledException();

      if (response.statusCode != 200) throw ServerException();

      return CoursesModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw ServerException();
    }
  }
}
