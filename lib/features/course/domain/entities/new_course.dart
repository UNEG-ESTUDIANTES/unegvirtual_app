import 'package:classroom_app/core/entities/course.dart';

class NewCourse {
  final Course course;
  final String auth;

  NewCourse({required this.course, required this.auth});

  @override
  List<Object?> get props => [course, auth];
}
