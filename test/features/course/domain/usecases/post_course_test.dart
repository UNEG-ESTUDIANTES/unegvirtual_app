import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/course.dart';
import 'package:unegvirtual_app/features/course/domain/entities/new_course.dart';
import 'package:unegvirtual_app/features/course/domain/repositories/courses_repository.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/post_course.dart';

@GenerateNiceMocks([MockSpec<CoursesRepository>()])
import 'post_course_test.mocks.dart';

void main() {
  late MockCoursesRepository mockCoursesRepository;
  late PostCourse useCase;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository();
    useCase = PostCourse(mockCoursesRepository);
  });

  const tAccessToken = AccessToken('test');

  const tNewCourse = NewCourse(
    name: 'test',
    description: 'test',
    teacherId: 'test',
  );

  const tCourse = Course(
    id: 'test',
    name: 'test',
    description: 'test',
    teacherId: 'test',
  );

  test(
    'should get the courses from the repository',
    () async {
      // arrange
      when(
        mockCoursesRepository.postCourse(
          accessToken: anyNamed('accessToken'),
          newCourse: anyNamed('newCourse'),
        ),
      ).thenAnswer((_) async => const Right(tCourse));

      // act
      final result = await useCase(
        const PostCourseParams(
          accessToken: tAccessToken,
          newCourse: tNewCourse,
        ),
      );

      // assert
      expect(result, const Right(tCourse));

      verify(
        mockCoursesRepository.postCourse(
          newCourse: tNewCourse,
          accessToken: tAccessToken,
        ),
      );

      verifyNoMoreInteractions(mockCoursesRepository);
    },
  );
}
