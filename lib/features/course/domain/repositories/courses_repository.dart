import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/features/course/domain/entities/inscription.dart';
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart';
import 'package:classroom_app/features/course/domain/entities/new_course.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';

abstract class CoursesRepository {
  Future<Either<Failure, Courses>> getCourses();

  Future<Either<Failure, Course>> postCourse({
    required NewCourse newCourse,
    required AccessToken accessToken,
  });

  Future<Either<Failure, Inscription>> enrollStudent({
    required Inscription inscription,
    required AccessToken accessToken,
  });

  Future<Either<Failure, void>> multiStudentsEnroll({
    required MultiEnroll multiEnroll,
    required AccessToken accessToken,
  });

  Future<Either<Failure, Courses>> enroledCourses(AccessToken accessToken);
}
