import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:classroom_app/core/env/env.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/features/landing/data/models/course_model.dart';

abstract class LandingRemoteDataSource {
  /// Calls the `/v1/courses` enpdoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CourseModel> getCourses();
}

class LandingRemoteDataSourceImpl implements LandingRemoteDataSource {
  final http.Client client;

  LandingRemoteDataSourceImpl({required this.client});

  @override
  Future<CourseModel> getCourses() =>
      _getCoursesFromUrl('${Env.appUrl}/v1/courses');

  Future<CourseModel> _getCoursesFromUrl(String url) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) throw ServerException();

      return CourseModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw ServerException();
    }
  }
}
