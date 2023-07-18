import 'package:dartz/dartz.dart';

import 'package:classroom_app/features/course/domain/entities/inscription.dart';
import 'package:classroom_app/features/course/domain/entities/multi_enroll.dart';
import 'package:classroom_app/features/course/domain/entities/new_course.dart';

import '../../../../core/entities/courses.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/courses_model.dart';

abstract class CoursesRepository {
  Future<Either<Failure, Courses>> getCourses();
  Future<Either<Failure, CourseElement>> postCourse(NewCourse newCourse);
  Future<Either<Failure, Inscription>> enrollStudent(Inscription inscription);
  Future<Either<Failure, void>> multiStudentsEnroll(MultiEnroll multiEnroll);
  Future<Either<Failure, Courses>> enroledCourses(String studentId);
}
