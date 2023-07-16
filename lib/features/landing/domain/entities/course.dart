import 'package:classroom_app/features/landing/data/models/course_model.dart';
import 'package:equatable/equatable.dart';

class Courses extends Equatable {
  final List<CourseElement> courses;

  Courses({required this.courses});

  @override
  List<Object?> get props => [courses];
}
