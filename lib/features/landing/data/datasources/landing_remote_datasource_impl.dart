import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:classroom_app/features/landing/data/models/course_model.dart';

import '../../../../core/error/failure.dart';

abstract class LandingRemoteDataSource {
  Future<CourseModel> getCourses();
}

class LandingRemoteDataSourceImpl implements LandingRemoteDataSource {
  final http.Client client;

  LandingRemoteDataSourceImpl({required this.client});

  @override
  Future<CourseModel> getCourses() =>
      _getCoursesFromUrl('http://localhost:3000/v1/courses');

  Future<CourseModel> _getCoursesFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final result = CourseModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerFailure();
    }
  }
}
