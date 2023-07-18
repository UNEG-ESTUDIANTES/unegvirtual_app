import 'package:equatable/equatable.dart';

class Course extends Equatable {
  /// The [id] of this course.
  final String id;

  /// The [name] of the course.
  final String name;

  /// The [description] of the course.
  final String description;

  /// The [teacherId] of the course.
  final String teacherId;

  const Course({
    required this.id,
    required this.name,
    required this.description,
    required this.teacherId,
  });

  @override
  List<Object> get props => [id, name, description, teacherId];
}
