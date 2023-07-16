import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/course.dart';

abstract class LandingRepository {
  Future<Either<Failure, Courses>> getCourses();
}