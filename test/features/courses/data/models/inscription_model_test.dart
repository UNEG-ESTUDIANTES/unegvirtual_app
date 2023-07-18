import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:classroom_app/features/course/data/models/inscription_model.dart';
import 'package:classroom_app/features/course/domain/entities/inscription.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tInscriptionModel = InscriptionModel(
    courseId: 'test',
    studentId: 'test',
  );

  test(
    'should be a subclass of InscriptionElement entity',
    () async {
      // assert
      expect(tInscriptionModel, isA<Inscription>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('inscription.json'));

        // act
        final result = InscriptionModel.fromJson(jsonMap);

        // assert
        expect(result, tInscriptionModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tInscriptionModel.toJson();

        // assert
        final expectedMap = {
          "courseId": tInscriptionModel.courseId,
          "studentId": tInscriptionModel.studentId,
        };

        expect(result, expectedMap);
      },
    );
  });
}
