import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/features/course/domain/entities/inscription.dart';
import 'package:unegvirtual_app/features/course/domain/repositories/courses_repository.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/enroll_student.dart';

@GenerateNiceMocks([MockSpec<CoursesRepository>()])
import 'enroled_courses_test.mocks.dart';

void main() {
  late MockCoursesRepository mockCoursesRepository;
  late EnrollStudent useCase;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository();
    useCase = EnrollStudent(mockCoursesRepository);
  });

  const tInscription = Inscription(courseId: 'test', studentId: 'test');
  const tAccessToken = AccessToken('test');

  test(
    'should enroll the student with the repository',
    () async {
      // arrange
      when(mockCoursesRepository.enrollStudent(
        accessToken: anyNamed('accessToken'),
        inscription: anyNamed('inscription'),
      )).thenAnswer((_) async => const Right(tInscription));

      // act
      final result = await useCase(
        const EnrollStudentParams(
          accessToken: tAccessToken,
          inscription: tInscription,
        ),
      );

      // assert
      expect(result, const Right(tInscription));

      verify(
        mockCoursesRepository.enrollStudent(
          inscription: tInscription,
          accessToken: tAccessToken,
        ),
      );

      verifyNoMoreInteractions(mockCoursesRepository);
    },
  );
}
