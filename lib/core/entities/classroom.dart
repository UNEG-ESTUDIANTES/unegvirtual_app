import 'package:equatable/equatable.dart';

class Classroom extends Equatable {
  /// The [name] of the classroom.
  final String name;

  const Classroom({required this.name});

  @override
  List<Object> get props => [name];
}
