import 'package:equatable/equatable.dart';

class Career extends Equatable {
  /// The [name] of the career.
  final String name;

  const Career({required this.name});

  @override
  List<Object> get props => [name];
}
