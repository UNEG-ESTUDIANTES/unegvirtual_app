import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/models/course_model.dart';
import 'package:unegvirtual_app/features/course/data/models/inscription_model.dart';
import 'package:unegvirtual_app/features/course/data/models/multi_enroll_model.dart';
import 'package:unegvirtual_app/features/course/data/models/new_course_model.dart';

import '../../../../core/env/env.dart';
import '../../../../core/models/courses_model.dart';

abstract class CoursesRemoteDataSource {
  /// Calls the `/v1/courses` endpoint.
  ///
  /// Throws [NotFoundException] when there are not courses available.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<CoursesModel> getCourses();

  /// Calls the `/v1/courses` endpoint.
  ///
  /// Throws a [NotAuthorizedException] when the user is not authed.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<CourseModel> postCourse({
    required NewCourseModel newCourse,
    required AccessToken accessToken,
  });

  /// Calls the `/v1/courses/:courseId/users/:studentId/inscriptions` endpoint.
  ///
  /// Throws a [NotAuthorizedException] when the user is not authed.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<InscriptionModel> enrollStudent({
    required InscriptionModel inscription,
    required AccessToken accessToken,
  });

  /// Calls the `/v1/enrolledCourses` endpoint.
  ///
  /// Throws a [NotEnrolledException] when the user is not enroled
  /// to any course.
  ///
  /// Throws a [ServerException] for all other error codes.
  Future<CoursesModel> enroledCourses(AccessToken accessToken);

  /// Calls the `/v1/courses/enroll-multiple-users` endpoint.
  ///
  /// Throws a [NotAuthorizedException] when the user is not authed.
  ///
  /// Otherwise throws a [ServerException] for all other error codes.
  Future<void> multiStudentEnroll({
    required MultiEnrollModel multiEnroll,
    required AccessToken accessToken,
  });
}

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final http.Client client;

  CoursesRemoteDataSourceImpl({required this.client});

  @override
  Future<CoursesModel> getCourses() async {
    try {
      final response = await client.get(
        Uri.parse('${Env.appUrl}/v1/courses'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 404) throw NotFoundException();

      if (response.statusCode != 200) throw ServerException();

      return CoursesModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw ServerException();
    }
  }

  @override
  Future<CourseModel> postCourse({
    required NewCourseModel newCourse,
    required AccessToken accessToken,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${Env.appUrl}/v1/courses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken.token}',
        },
        body: json.encode(newCourse.toJson()),
      );

      if (response.statusCode == 403) throw NotAuthorizedException();

      if (response.statusCode != 200) throw ServerException();

      return CourseModel.fromJson(json.decode(response.body)['course']);
    } on http.ClientException {
      throw ServerException();
    }
  }

  @override
  Future<InscriptionModel> enrollStudent({
    required InscriptionModel inscription,
    required AccessToken accessToken,
  }) async {
    final url =
        '${Env.appUrl}/v1/courses/${inscription.courseId}/users/${inscription.studentId}/inscriptions';

    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken.token}',
        },
        body: json.encode(inscription.toJson()),
      );

      if (response.statusCode == 403) throw NotAuthorizedException();

      if (response.statusCode != 200) throw ServerException();

      return InscriptionModel.fromJson(
        json.decode(response.body)['inscription'],
      );
    } on http.ClientException {
      throw ServerException();
    }
  }

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

  @override
  Future<void> multiStudentEnroll({
    required MultiEnrollModel multiEnroll,
    required AccessToken accessToken,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${Env.appUrl}/v1/courses/enroll-multiple-users'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessToken.token}',
        },
        body: json.encode(multiEnroll.toJson()),
      );

      if (response.statusCode == 403) throw NotAuthorizedException();

      if (response.statusCode != 200) throw ServerException();
    } on http.ClientException {
      throw ServerException();
    }
  }
}
