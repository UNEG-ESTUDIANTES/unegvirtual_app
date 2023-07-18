import 'package:equatable/equatable.dart';

class NewCourse extends Equatable {
  /// The [name] of the course.
  final String name;

  /// The [description] of the course.
  final String description;

  /// The [teacherId] of the course.
  final String teacherId;

  const NewCourse({
    required this.name,
    required this.description,
    required this.teacherId,
  });

  @override
  List<Object> get props => [name, description, teacherId];
}
