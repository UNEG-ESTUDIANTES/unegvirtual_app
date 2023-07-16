import 'package:classroom_app/core/models/course_model.dart';

class NewCourse {
  final CourseElement course;
  final String auth;

  NewCourse({required this.course, required this.auth});

  @override
  List<Object?> get props => [course, auth];
}
