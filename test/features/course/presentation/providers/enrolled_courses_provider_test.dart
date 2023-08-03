import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/course.dart';
import 'package:unegvirtual_app/core/entities/entities.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/get_enrolled_courses.dart';
import 'package:unegvirtual_app/features/course/presentation/providers/enrolled_courses_provider.dart';

@GenerateNiceMocks([MockSpec<GetEnrolledCourses>()])
import 'enrolled_courses_provider_test.mocks.dart';

void main() {
  // Initialize the binding.
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetEnrolledCourses mockGetEnrolledCourses;
  late EnrolledCoursesProvider provider;

  setUp(() {
    mockGetEnrolledCourses = MockGetEnrolledCourses();

    provider = EnrolledCoursesProvider(
      getEnrolledCourses: mockGetEnrolledCourses,
    );
  });

  const tAccessToken = AccessToken('test');
  const tCourses = Courses(courses: []);

  test(
    'initial state should be Empty',
    () async {
      // assert
      expect(provider.state, Empty());
    },
  );

  group('getEnrolledCourses', () {
    test(
      'should get the courses with the use case',
      () async {
        // arrange
        when(mockGetEnrolledCourses(any))
            .thenAnswer((_) async => const Right(tCourses));

        // act
        await provider.getEnrolledCourses(accessToken: tAccessToken);

        // assert
        verify(
          mockGetEnrolledCourses(
            const GetEnrolledCoursesParams(accessToken: tAccessToken),
          ),
        );
      },
    );

    test(
      'should notify [Loading, Loaded] when courses are gotten successfully',
      () async {
        // arrange
        when(mockGetEnrolledCourses(any))
            .thenAnswer((_) async => const Right(tCourses));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getEnrolledCourses(accessToken: tAccessToken);
      },
    );

    test(
      'should notify [Loading, Error] when getting courses fails',
      () async {
        // arrange
        when(mockGetEnrolledCourses(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: serverFailureMessage),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getEnrolledCourses(accessToken: tAccessToken);
      },
    );
  });

  group('filter', () {
    const tCourseNameToFilter = 'test 1';

    const tCourseFilter = Course(
      id: '1',
      name: tCourseNameToFilter,
      description: 'test 1',
      teacherId: '1',
    );

    const tCoursesToFilter = Courses(courses: [
      Course(
        id: '1',
        name: 'test',
        description: 'test',
        teacherId: '1',
      ),
      tCourseFilter,
    ]);

    Future<void> setUpEnrolledCourses() async {
      when(mockGetEnrolledCourses(any))
          .thenAnswer((_) async => const Right(tCoursesToFilter));

      await provider.getEnrolledCourses(accessToken: tAccessToken);
    }

    test(
      'should not filter when enrolled courses is null',
      () async {
        // act
        provider.filter('test');

        // assert
        expect(provider.enrolledCourses, null);
        expect(provider.filteredCourses, null);
      },
    );

    test(
      'should not filter when the query is empty',
      () async {
        // arrange
        await setUpEnrolledCourses();

        // act
        provider.filter('');

        // assert
        expect(provider.enrolledCourses, tCoursesToFilter);
        expect(provider.filteredCourses, null);
      },
    );

    test(
      'should filter by name',
      () async {
        // arrange
        await setUpEnrolledCourses();

        // act
        provider.filter(tCourseNameToFilter);

        // assert
        expect(provider.enrolledCourses, tCoursesToFilter);
        expect(
          provider.filteredCourses,
          const Courses(courses: [tCourseFilter]),
        );
      },
    );
  });
}
