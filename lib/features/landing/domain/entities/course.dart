import 'package:equatable/equatable.dart';

import 'package:classroom_app/features/landing/data/models/course_model.dart';

class Courses extends Equatable {
  final List<CourseElement> courses;

  const Courses({required this.courses});

  @override
  List<Object?> get props => [courses];
}
