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
  Future<CoursesModel> getCourses();

  Future<CourseModel> postCourse(NewCourse newCourse, AccessToken accessToken);

  Future<InscriptionModel> enrollStudent(
    Inscription inscription,
    AccessToken accessToken,
  );

  Future<CoursesModel> enroledCourses(AccessToken accessToken);

  Future<void> multiStudentEnroll(
    MultiEnroll multiEnroll,
    AccessToken accessToken,
  );
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
  Future<CourseModel> postCourse(
      NewCourse newCourse, AccessToken accessToken) async {
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
  Future<InscriptionModel> enrollStudent(
    Inscription inscription,
    AccessToken accessToken,
  ) async {
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
  Future<InscriptionModel> multiStudentEnroll(
    MultiEnroll multiEnroll,
    AccessToken accessToken,
  ) async {
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
