import 'package:equatable/equatable.dart';

class MultiEnroll extends Equatable {
  final List<String> studentIds;
  final String courseId;
  final String? auth;

  const MultiEnroll({
    required this.studentIds,
    required this.courseId,
    this.auth,
  });

  @override
  List<Object?> get props => [studentIds, courseId, auth];
}
