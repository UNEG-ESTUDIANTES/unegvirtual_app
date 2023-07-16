import 'dart:convert';

import 'package:classroom_app/core/providers/auth_provider.dart';
import 'package:classroom_app/features/course/data/models/inscription_model.dart';
import 'package:classroom_app/features/course/domain/entities/new_course.dart';
import 'package:classroom_app/features/course/domain/usecases/enroled_courses.dart';
import 'package:http/http.dart' as http;

import '../../../../core/env/env.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/course_model.dart';
import '../../domain/entities/inscription.dart';

abstract class CoursesRemoteDataSource {
  Future<CoursesModel> getCourses();
  Future<CourseElement> postCourse(NewCourse newCourse);
  Future<InscriptionModel> enrollStudent(Inscription inscription);
  Future<CoursesModel> enroledCourses(String id);
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
  Future<CourseElement> postCourse(NewCourse newCourse) =>
      _postCourseToUrl('${Env.appUrl}/v1/courses', newCourse);

  Future<CourseElement> _postCourseToUrl(
      String url, NewCourse newCourse) async {
    final response = await client.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': newCourse.auth
    }, body: {
      "name": newCourse.course.name,
      "description": newCourse.course.description,
      "teacherId": newCourse.course.teacherId,
    });
    if (response.statusCode == 200) {
      final result = CourseElement.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<InscriptionModel> enrollStudent(Inscription inscription) => _enrollStuden(
      '${Env.appUrl}/v1/courses/${inscription.inscription.courseId}/users/${inscription.inscription.studentId}/inscriptions',
      inscription);

  Future<InscriptionModel> _enrollStuden(
      String url, Inscription inscription) async {
    final response = await client.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': inscription.auth!
    });
    if (response.statusCode == 200) {
      final result = InscriptionModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<CoursesModel> enroledCourses(String id) =>
      _enroledCourses('${Env.appUrl}/v1/courses', id);

  Future<CoursesModel> _enroledCourses(String url, String id) async {
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
