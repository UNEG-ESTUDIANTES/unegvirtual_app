import 'package:equatable/equatable.dart';

class MultiEnroll extends Equatable {
  /// The [courseId] where the students will be enrolled.
  final String courseId;

  /// The [studentIds] to enroll in the course.
  final List<String> studentIds;

  const MultiEnroll({
    required this.courseId,
    required this.studentIds,
  });

  @override
  List<Object?> get props => [studentIds, courseId];
}
