import '../../../../core/entities/course.dart';
import '../../../../core/providers/base_provider.dart';
import '../../../../core/providers/page_state.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/usecases/post_course.dart';

class CreateCourseProvider extends BaseProvider {
  final PostCourse _postCourse;

  CreateCourseProvider({
    required PostCourse postCourse,
  }) : _postCourse = postCourse;

  Course? course;

  Future<void> postCourse(PostCourseParams post) async {
    state = Loading();
    final failureOrCourses = await _postCourse(post);

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
