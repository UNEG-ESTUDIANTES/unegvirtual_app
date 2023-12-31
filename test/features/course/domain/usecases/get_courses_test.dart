import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/features/course/domain/repositories/courses_repository.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/get_courses.dart';

@GenerateNiceMocks([MockSpec<CoursesRepository>()])
import 'get_courses_test.mocks.dart';

void main() {
  late MockCoursesRepository mockCoursesRepository;
  late GetCourses useCase;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository();
    useCase = GetCourses(mockCoursesRepository);
  });

  const tCourses = Courses(courses: []);

  test(
    'should get the courses from the repository',
    () async {
      // arrange
      when(mockCoursesRepository.getCourses())
          .thenAnswer((_) async => const Right(tCourses));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(tCourses));
      verify(mockCoursesRepository.getCourses());
      verifyNoMoreInteractions(mockCoursesRepository);
    },
  );
}
