import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/entities.dart';
import 'package:unegvirtual_app/core/providers/base_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/features/course/domain/usecases/get_enrolled_courses.dart';

class EnrolledCoursesProvider extends BaseProvider {
  final GetEnrolledCourses _getEnrolledCourses;

  EnrolledCoursesProvider({
    required GetEnrolledCourses getEnrolledCourses,
  }) : _getEnrolledCourses = getEnrolledCourses;

  Courses? _enrolledCourses;

  /// The [enrolledCourses] that the user is enrolled to.
  Courses? get enrolledCourses => _enrolledCourses;

  /// Gets the [Courses] the user is enrolled to.
  Future<void> getEnrolledCourses({required AccessToken accessToken}) async {
    state = Loading();

    final failureOrCourses = await _getEnrolledCourses(
      GetEnrolledCoursesParams(accessToken: accessToken),
    );

    failureOrCourses.fold(
      (failure) => onFailure(failure),
      (courses) {
        state = const Loaded();
        _enrolledCourses = courses;
      },
    );
  }
}
