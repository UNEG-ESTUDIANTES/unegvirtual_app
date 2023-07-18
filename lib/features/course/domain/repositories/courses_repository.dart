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

  Future<Either<Failure, Course>> postCourse(
    NewCourse newCourse,
    AccessToken accessToken,
  );

  Future<Either<Failure, Inscription>> enrollStudent(
    Inscription inscription,
    AccessToken accessToken,
  );

  Future<Either<Failure, void>> multiStudentsEnroll(
    MultiEnroll multiEnroll,
    AccessToken accessToken,
  );

  Future<Either<Failure, Courses>> enroledCourses(AccessToken accessToken);
}
