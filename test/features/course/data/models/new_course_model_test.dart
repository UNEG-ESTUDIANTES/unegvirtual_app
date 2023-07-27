import 'package:flutter_test/flutter_test.dart';

import 'package:unegvirtual_app/features/course/data/models/new_course_model.dart';
import 'package:unegvirtual_app/features/course/domain/entities/new_course.dart';

void main() {
  const tNewCourseModel = NewCourseModel(
    description: 'test',
    name: 'test',
    teacherId: 'test',
  );

  test(
    'should be a subclass of NewCourse entity',
    () async {
      // assert
      expect(tNewCourseModel, isA<NewCourse>());
    },
  );

  group('fromEntity', () {
    const tNewCourse = NewCourse(
      description: 'test',
      name: 'test',
      teacherId: 'test',
    );

    test(
      'should return an NewCourseModel',
      () async {
        // act
        final result = NewCourseModel.fromEntity(tNewCourse);

        // assert
        expect(result, isA<NewCourseModel>());
      },
    );

    test(
      'should contain the same data as the NewCourse',
      () async {
        // act
        final result = NewCourseModel.fromEntity(tNewCourse);

        // assert
        expect(result.description, tNewCourse.description);
        expect(result.name, tNewCourse.name);
        expect(result.teacherId, tNewCourse.teacherId);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tNewCourseModel.toJson();

        // assert
        final expectedMap = {
          'description': tNewCourseModel.description,
          'name': tNewCourseModel.name,
          'teacherId': tNewCourseModel.teacherId,
        };

        expect(result, expectedMap);
      },
    );
  });
}
