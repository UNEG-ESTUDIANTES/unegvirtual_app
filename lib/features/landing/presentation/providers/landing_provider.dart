import 'package:classroom_app/core/providers/base_provider.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/utils/utils.dart';
import 'package:classroom_app/features/landing/domain/entities/course.dart';
import 'package:classroom_app/features/landing/domain/usecases/get_courses.dart';

import '../../../../core/use_cases/use_case.dart';

class LandingProvider extends BaseProvider {
  final GetCourses _getCourses;

  LandingProvider({
    required GetCourses getCourses,
  }) : _getCourses = getCourses;

  Courses? courses;

  Future<void> getCoursesList() async {
    state = Loading();
    final failureOrCourses = await _getCourses(NoParams());

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
