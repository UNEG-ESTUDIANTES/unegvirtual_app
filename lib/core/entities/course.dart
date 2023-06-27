import 'package:equatable/equatable.dart';

class Course extends Equatable {
  /// The [name] of the course.
  final String name;

  const Course({required this.name});

  @override
  List<Object> get props => [name];
}
