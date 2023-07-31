import 'package:dartz/dartz.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/get_courses.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/get_enrolled_courses.dart';

import '../../../../core/entities/course.dart';
import '../../../../core/providers/base_provider.dart';
import '../../../../core/providers/page_state.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/usecases/multi_students_enroll.dart';
import '../../domain/usecases/post_course.dart';

class CourseProvider extends BaseProvider {
  final GetCourses _getCourses;
  final PostCourse _postCourse;
  final MultiStudentsEnroll _multiStudentsEnroll;
  final GetEnrolledCourses _getEnrolledCourses;

  CourseProvider({
    required PostCourse postCourse,
    required MultiStudentsEnroll multiStudentsEnroll,
    required GetCourses getCourses,
    required GetEnrolledCourses getEnrolledCourses,
  })  : _postCourse = postCourse,
        _multiStudentsEnroll = multiStudentsEnroll,
        _getCourses = getCourses,
        _getEnrolledCourses = getEnrolledCourses;

  Course? course;
  Courses? _courses;
  Courses? _enrolledCourses;

  /// The [courses].
  Courses? get courses => _courses;

  /// The [enrolledCourses] that the user is enrolled to.
  Courses? get enrolledCourses => _enrolledCourses;

  Future<void> getCourses() async {
    state = Loading();

    _courses = _eitherLoadedCoursesOrErrorState(await _getCourses(NoParams()));
  }

  Future<void> getEnrolledCourses({required AccessToken accessToken}) async {
    state = Loading();

    _enrolledCourses = _eitherLoadedCoursesOrErrorState(
      await _getEnrolledCourses(
        GetEnrolledCoursesParams(accessToken: accessToken),
      ),
    );
  }

  Future<void> multiStudentsEnroll(MultiStudentsEnrollParams params) async {
    state = Loading();
    final failureOrCourses = await _multiStudentsEnroll(params);

    // Handle success or error
    failureOrCourses.fold(
      (failure) {
        state = Error(message: Utils.getErrorMessage(failure));
      },
      (enrollResult) {
        state = const Loaded();
      },
    );
  }

  Future<void> postCourse(PostCourseParams params) async {
    state = Loading();
    final failureOrCourses = await _postCourse(params);

    // Handle success or error
    failureOrCourses.fold(
      (failure) {
        state = Error(message: Utils.getErrorMessage(failure));
      },
      (postResult) {
        state = const Loaded();
        course = postResult;
      },
    );
  }

  /// Changes the [state] according to [failureOrCourses].
  Courses? _eitherLoadedCoursesOrErrorState(
    Either<Failure, Courses> failureOrCourses,
  ) {
    return failureOrCourses.fold(
      (failure) {
        state = Error(message: Utils.getErrorMessage(failure));

        return null;
      },
      (courses) {
        state = const Loaded();

        return courses;
      },
    );
  }
}
