import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/courses.dart';
import 'package:classroom_app/features/home/domain/usecases/enroled_courses.dart';

import '../../../../core/providers/base_provider.dart';
import '../../../../core/providers/page_state.dart';
import '../../../../core/utils/utils.dart';

class HomeProvider extends BaseProvider {
  final HomeEnroledCourses _enroledCourses;

  HomeProvider({required HomeEnroledCourses enroledCourses})
      : _enroledCourses = enroledCourses;

  Courses? courses;

  Future<void> enroledCourses(AccessToken accessToken) async {
    state = Loading();
    final failureOrCourses = await _enroledCourses(accessToken);

    // Handle success or error
    failureOrCourses.fold(
      (failure) {
        state = Error(message: Utils.getErrorMessage(failure));
      },
      (coursesResult) {
        state = const Loaded();
        courses = coursesResult;
      },
    );
  }
}
