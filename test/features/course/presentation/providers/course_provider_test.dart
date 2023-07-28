import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/get_courses.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/multi_students_enroll.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/post_course.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/course_provider.dart';

@GenerateNiceMocks([
  MockSpec<GetCourses>(),
  MockSpec<PostCourse>(),
  MockSpec<MultiStudentsEnroll>()
])
import 'course_provider_test.mocks.dart';

void main() {
  late MockGetCourses mockGetCourses;
  late MockPostCourse mockPostCourse;
  late MockMultiStudentsEnroll mockMultiStudentsEnroll;
  late CourseProvider provider;

  setUp(() {
    mockGetCourses = MockGetCourses();
    mockPostCourse = MockPostCourse();
    mockMultiStudentsEnroll = MockMultiStudentsEnroll();

    provider = CourseProvider(
      postCourse: mockPostCourse,
      multiStudentsEnroll: mockMultiStudentsEnroll,
      getCourses: mockGetCourses,
    );
  });

  const tCourses = Courses(courses: []);

  test(
    'initial state should be Empty',
    () async {
      // assert
      expect(provider.state, Empty());
    },
  );

  group('getCourses', () {
    test(
      'should get the courses with the use case',
      () async {
        // arrange
        when(mockGetCourses(any))
            .thenAnswer((_) async => const Right(tCourses));

        // act
        await provider.getCourses();

        // assert
        verify(mockGetCourses(NoParams()));
      },
    );

    test(
      'should notify [Loading, Loaded] when courses are gotten successfully',
      () async {
        // arrange
        when(mockGetCourses(any))
            .thenAnswer((_) async => const Right(tCourses));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getCourses();
      },
    );

    test(
      'should notify [Loading, Error] when fails getting courses',
      () async {
        // arrange
        when(mockGetCourses(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: serverFailureMessage),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getCourses();
      },
    );
  });
}
