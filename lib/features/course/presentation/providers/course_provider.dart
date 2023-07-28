import 'package:unegvirtual_app/core/entities/courses.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/get_courses.dart';

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

  CourseProvider({
    required PostCourse postCourse,
    required MultiStudentsEnroll multiStudentsEnroll,
    required GetCourses getCourses,
  })  : _postCourse = postCourse,
        _multiStudentsEnroll = multiStudentsEnroll,
        _getCourses = getCourses;

  Course? course;
  Courses? _courses;

  /// The [courses].
  Courses? get courses => _courses;

  Future<void> getCourses() async {
    state = Loading();
    final failureOrCourses = await _getCourses(NoParams());

    // Handle success or error
    failureOrCourses.fold(
      (failure) {
        state = Error(message: Utils.getErrorMessage(failure));
      },
      (courses) {
        state = const Loaded();
        _courses = courses;
      },
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
}
