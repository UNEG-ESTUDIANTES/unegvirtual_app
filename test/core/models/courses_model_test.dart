import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:unegvirtual_app/core/entities/course.dart';
import 'package:unegvirtual_app/core/entities/entities.dart';
import 'package:unegvirtual_app/core/models/course_model.dart';
import 'package:unegvirtual_app/core/models/courses_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tCourseModel = CourseModel(
    id: 'test',
    description: 'test',
    name: 'test',
    teacherId: 'test',
  );

  const Course tCourse = tCourseModel;

  const tCoursesModel = CoursesModel(courses: [tCourse]);

  test(
    'should be a subclass of Courses entity',
    () async {
      // assert
      expect(tCoursesModel, isA<Courses>());
    },
  );

  group('courses', () {
    test(
      'should be a List<CourseModel>',
      () async {
        // assert
        expect(tCoursesModel.courses, isA<List<CourseModel>>());
      },
    );
  });

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('courses.json'));

        // act
        final result = CoursesModel.fromJson(jsonMap);

        // assert
        expect(result, tCoursesModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCoursesModel.toJson();

        // assert
        final expectedMap = {
          "courses": List.from(
            tCoursesModel.courses.map(
              (course) => course.toJson(),
            ),
          ),
        };

        expect(result, expectedMap);
      },
    );
  });
}
