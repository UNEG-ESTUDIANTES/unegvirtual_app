import '../../../../core/entities/course.dart';
import '../../../../core/providers/base_provider.dart';
import '../../../../core/providers/page_state.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/usecases/post_course.dart';
import '../../domain/usecases/multi_students_enroll.dart';

class CourseProvider extends BaseProvider {
  final PostCourse _postCourse;
  final MultiStudentsEnroll _multiStudentsEnroll;

  CourseProvider(
      {required PostCourse postCourse,
      required MultiStudentsEnroll multiStudentsEnroll})
      : _postCourse = postCourse,
        _multiStudentsEnroll = multiStudentsEnroll;

  Course? course;

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
