import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/features/course/domain/repositories/courses_repository.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/get_enrolled_courses.dart';

@GenerateNiceMocks([MockSpec<CoursesRepository>()])
import 'get_enrolled_courses_test.mocks.dart';

void main() {
  late MockCoursesRepository mockCoursesRepository;
  late GetEnrolledCourses useCase;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository();
    useCase = GetEnrolledCourses(mockCoursesRepository);
  });

  const tCourses = Courses(courses: []);
  const tAccessToken = AccessToken('test');

  test(
    'should get the courses from the repository',
    () async {
      // arrange
      when(mockCoursesRepository.getEnrolledCourses(any))
          .thenAnswer((_) async => const Right(tCourses));

      // act
      final result = await useCase(
        const GetEnrolledCoursesParams(accessToken: tAccessToken),
      );

      // assert
      expect(result, const Right(tCourses));
      verify(mockCoursesRepository.getEnrolledCourses(tAccessToken));
      verifyNoMoreInteractions(mockCoursesRepository);
    },
  );
}
