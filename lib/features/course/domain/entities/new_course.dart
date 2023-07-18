import 'package:equatable/equatable.dart';

import 'package:classroom_app/core/entities/course.dart';

class NewCourse extends Equatable {
  final Course course;
  final String auth;

  const NewCourse({required this.course, required this.auth});

  @override
  List<Object?> get props => [course, auth];
}
