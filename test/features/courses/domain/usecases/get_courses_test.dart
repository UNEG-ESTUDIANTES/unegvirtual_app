import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/courses.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/course/domain/repositories/courses_repository.dart';
import 'package:classroom_app/features/course/domain/usecases/get_courses.dart';

@GenerateNiceMocks([MockSpec<CoursesRepository>()])
import 'get_courses_test.mocks.dart';

void main() {
  late MockCoursesRepository mockCoursesRepository;
  late CoursesGetCourses useCase;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository();
    useCase = CoursesGetCourses(mockCoursesRepository);
  });

  const tCourses = Courses(courses: []);

  test(
    'should get the courses from the repository',
    () async {
      // arrange
      when(mockCoursesRepository.coursesGetCourses())
          .thenAnswer((_) async => const Right(tCourses));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(tCourses));
      verify(mockCoursesRepository.coursesGetCourses());
      verifyNoMoreInteractions(mockCoursesRepository);
    },
  );
}
