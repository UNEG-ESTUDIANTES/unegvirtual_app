import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/features/course/domain/entities/multi_enroll.dart';
import 'package:unegvirtual_app/features/course/domain/repositories/courses_repository.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/multi_students_enroll.dart';

@GenerateNiceMocks([MockSpec<CoursesRepository>()])
import 'multi_students_enroll_test.mocks.dart';

void main() {
  late MockCoursesRepository mockCoursesRepository;
  late MultiStudentsEnroll useCase;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository();
    useCase = MultiStudentsEnroll(mockCoursesRepository);
  });

  const tAccessToken = AccessToken('test');
  const tMultiEnroll = MultiEnroll(courseId: 'test', studentIds: []);

  test(
    'should get the courses from the repository',
    () async {
      // arrange
      when(mockCoursesRepository.multiStudentsEnroll(
        accessToken: anyNamed('accessToken'),
        multiEnroll: anyNamed('multiEnroll'),
      )).thenAnswer((_) async => const Right(null));

      // act
      final result = await useCase(
        const MultiStudentsEnrollParams(
          accessToken: tAccessToken,
          multiEnroll: tMultiEnroll,
        ),
      );

      // assert
      expect(result, const Right(null));

      verify(
        mockCoursesRepository.multiStudentsEnroll(
          multiEnroll: tMultiEnroll,
          accessToken: tAccessToken,
        ),
      );

      verifyNoMoreInteractions(mockCoursesRepository);
    },
  );
}
