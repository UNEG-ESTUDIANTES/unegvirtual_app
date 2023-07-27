import 'package:flutter_test/flutter_test.dart';

import 'package:unegvirtual_app/features/course/data/models/multi_enroll_model.dart';
import 'package:unegvirtual_app/features/course/domain/entities/multi_enroll.dart';

void main() {
  const tMultiEnrollModel = MultiEnrollModel(courseId: 'test', studentIds: []);

  test(
    'should be a subclass of MultiEnroll entity',
    () async {
      // assert
      expect(tMultiEnrollModel, isA<MultiEnroll>());
    },
  );

  group('fromEntity', () {
    const tMultiEnroll = MultiEnroll(
      courseId: 'test',
      studentIds: [],
    );

    test(
      'should return an InscriptionModel',
      () async {
        // act
        final result = MultiEnrollModel.fromEntity(tMultiEnroll);

        // assert
        expect(result, isA<MultiEnrollModel>());
      },
    );

    test(
      'should contain the same data as the Inscription',
      () async {
        // act
        final result = MultiEnrollModel.fromEntity(tMultiEnroll);

        // assert
        expect(result.courseId, tMultiEnrollModel.courseId);
        expect(result.studentIds, tMultiEnrollModel.studentIds);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tMultiEnrollModel.toJson();

        // assert
        final expectedMap = {
          "courseId": tMultiEnrollModel.courseId,
          "studentIds": tMultiEnrollModel.studentIds,
        };

        expect(result, expectedMap);
      },
    );
  });
}
