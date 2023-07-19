import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/entities/courses.dart';

abstract class LandingRepository {
  Future<Either<Failure, Courses>> getCourses();
}
