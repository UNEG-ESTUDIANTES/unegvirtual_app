import 'package:dartz/dartz.dart';

import '../../../../core/entities/access_token.dart';
import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';

abstract class HomeRepository {
  /// Gets the [Courses] that the user is enrolled to.
  Future<Either<Failure, Courses>> enroledCourses(AccessToken accessToken);
}
