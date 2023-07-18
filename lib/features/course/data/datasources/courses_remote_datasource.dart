import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/models/course_model.dart';
import 'package:classroom_app/features/course/data/models/inscription_model.dart';
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart';
import 'package:classroom_app/features/course/domain/entities/new_course.dart';

import '../../../../core/env/env.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/courses_model.dart';
import '../../domain/entities/inscription.dart';

abstract class CoursesRemoteDataSource {
  /// Calls the `/v1/courses` endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CoursesModel> getCourses();

  /// Calls the `/v1/courses` endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CourseModel> postCourse({
    required NewCourse newCourse,
    required AccessToken accessToken,
  });

  /// Calls the `/v1/courses/:courseId/users/:userId/inscriptions` endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<InscriptionModel> enrollStudent({
    required Inscription inscription,
    required AccessToken accessToken,
  });

  /// Calls the `/v1/enrolledCourses` endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CoursesModel> enroledCourses(AccessToken accessToken);

  /// Calls the `/v1/courses/enroll-multiple-users` endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> multiStudentEnroll({
    required MultiEnroll multiEnroll,
    required AccessToken accessToken,
  });
}

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final http.Client client;

  CoursesRemoteDataSourceImpl({required this.client});

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

  @override
  Future<CourseModel> postCourse({
    required NewCourse newCourse,
    required AccessToken accessToken,
  }) async {
    final response =
        await client.post(Uri.parse('${Env.appUrl}/v1/courses'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${accessToken.token}',
    }, body: {
      "name": newCourse.name,
      "description": newCourse.description,
      "teacherId": newCourse.teacherId,
    });

    if (response.statusCode == 200) {
      final result = CourseModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<InscriptionModel> enrollStudent({
    required Inscription inscription,
    required AccessToken accessToken,
  }) async {
    final url =
        '${Env.appUrl}/v1/courses/${inscription.courseId}/users/${inscription.studentId}/inscriptions';

    final response = await client.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${accessToken.token}',
    });

    if (response.statusCode == 200) {
      final result = InscriptionModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<CoursesModel> enroledCourses(AccessToken accessToken) async {
    final response = await client.get(
      Uri.parse('${Env.appUrl}/v1/enrolledCourses'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${accessToken.token}',
      },
    );

    if (response.statusCode == 200) {
      final result = CoursesModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<InscriptionModel> multiStudentEnroll({
    required MultiEnroll multiEnroll,
    required AccessToken accessToken,
  }) async {
    final response = await client.post(
      Uri.parse('${Env.appUrl}/v1/courses/enroll-multiple-users'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken.token,
      },
    );

    if (response.statusCode == 200) {
      final result = InscriptionModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerFailure();
    }
  }
}
