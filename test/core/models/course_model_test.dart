import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/core/models/course_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tCourseModel = CourseModel(
    id: 'test',
    description: 'test',
    name: 'test',
    teacherId: 'test',
  );

  test(
    'should be a subclass of Course entity',
    () async {
      // assert
      expect(tCourseModel, isA<Course>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('course.json'));

        // act
        final result = CourseModel.fromJson(jsonMap);

        // assert
        expect(result, tCourseModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCourseModel.toJson();

        // assert
        final expectedMap = {
          "_id": tCourseModel.id,
          "name": tCourseModel.name,
          "description": tCourseModel.description,
          "teacherId": tCourseModel.teacherId,
        };

        expect(result, expectedMap);
      },
    );
  });
}
