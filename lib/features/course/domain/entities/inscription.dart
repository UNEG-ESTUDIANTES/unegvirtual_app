import 'package:equatable/equatable.dart';

class Inscription extends Equatable {
  /// The [studentId] to enroll in the course.
  final String studentId;

  /// The [courseId] where the student will be enroled.
  final String courseId;

  const Inscription({required this.courseId, required this.studentId});

  @override
  List<Object?> get props => [courseId, studentId];
}
