import 'package:dartz/dartz.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/course.dart';
import 'package:classroom_app/features/course/domain/entities/inscription.dart';
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart';
import 'package:classroom_app/features/course/domain/entities/new_course.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';

abstract class CoursesRepository {
  /// Gets the public [Courses].
  Future<Either<Failure, Courses>> coursesGetCourses();

  /// Creates a new [Course] from the [newCourse].
  Future<Either<Failure, Course>> postCourse({
    required NewCourse newCourse,
    required AccessToken accessToken,
  });

  /// Enrolls an student with an [inscription].
  Future<Either<Failure, Inscription>> enrollStudent({
    required Inscription inscription,
    required AccessToken accessToken,
  });

  /// Enrolls multiple students to a course.
  Future<Either<Failure, void>> multiStudentsEnroll({
    required MultiEnroll multiEnroll,
    required AccessToken accessToken,
  });

  /// Gets the [Courses] that the user is enrolled to.
  Future<Either<Failure, Courses>> enroledCourses(AccessToken accessToken);
}
