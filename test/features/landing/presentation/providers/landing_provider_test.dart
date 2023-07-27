import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/course.dart';
import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';
import 'package:unegvirtual_app/features/landing/domain/usecases/get_courses.dart';
import 'package:unegvirtual_app/features/landing/presentation/providers/landing_provider.dart';

@GenerateNiceMocks([MockSpec<GetCourses>(), MockSpec<Utils>()])
import 'landing_provider_test.mocks.dart';

void main() {
  late MockGetCourses mockGetCourses;
  late LandingProvider provider;

  setUp(() {
    mockGetCourses = MockGetCourses();

    provider = LandingProvider(
      getCourses: mockGetCourses,
    );
  });

  const tCourses = Courses(
    courses: [
      Course(
        id: 'test',
        name: 'test',
        description: 'test',
        teacherId: 'test',
      ),
    ],
  );

  test(
    'initial state should be Empty',
    () async {
      // assert
      expect(provider.state, Empty());
    },
  );

  group('getCoursesList', () {
    test(
      'should get the courses with the use case',
      () async {
        // arrange
        when(mockGetCourses(any))
            .thenAnswer((_) async => const Right(tCourses));

        // act
        await provider.getCoursesList();

        // assert
        verify(mockGetCourses(NoParams()));
      },
    );

    test(
      'should notify [Loading, Loaded] when the courses are gotten successfully',
      () async {
        // arrange
        when(mockGetCourses(any))
            .thenAnswer((_) async => const Right(tCourses));

        // assert later
        final expected = [Empty(), Loading(), const Loaded()];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getCoursesList();
      },
    );

    test(
      'should notify [Loading, Error] when getting courses fails',
      () async {
        // arrange
        when(mockGetCourses(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: Utils.getErrorMessage(ServerFailure())),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getCoursesList();
      },
    );
  });
}
