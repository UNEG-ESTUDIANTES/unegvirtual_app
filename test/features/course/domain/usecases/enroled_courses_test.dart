import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/features/course/domain/repositories/courses_repository.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/enroled_courses.dart';

@GenerateNiceMocks([MockSpec<CoursesRepository>()])
import 'enroled_courses_test.mocks.dart';

void main() {
  late MockCoursesRepository mockCoursesRepository;
  late EnroledCourses useCase;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository();
    useCase = EnroledCourses(mockCoursesRepository);
  });

  const tCourses = Courses(courses: []);
  const tAccessToken = AccessToken('test');

  test(
    'should get the courses from the repository',
    () async {
      // arrange
      when(mockCoursesRepository.enroledCourses(any))
          .thenAnswer((_) async => const Right(tCourses));

      // act
      final result = await useCase(
        const EnroledCoursesParams(accessToken: tAccessToken),
      );

      // assert
      expect(result, const Right(tCourses));
      verify(mockCoursesRepository.enroledCourses(tAccessToken));
      verifyNoMoreInteractions(mockCoursesRepository);
    },
  );
}
