import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:classroom_app/core/env/env.dart';
import 'package:classroom_app/core/models/course_model.dart';

import '../../../../core/error/failures.dart';

abstract class LandingRemoteDataSource {
  Future<CoursesModel> getCourses();
}

class LandingRemoteDataSourceImpl implements LandingRemoteDataSource {
  final http.Client client;

  LandingRemoteDataSourceImpl({required this.client});

  @override
  Future<CoursesModel> getCourses() =>
      _getCoursesFromUrl('${Env.appUrl}/v1/courses');

  Future<CoursesModel> _getCoursesFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final result = CoursesModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerFailure();
    }
  }
}
