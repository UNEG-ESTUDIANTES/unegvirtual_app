import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  /// The [name] of the unit.
  final String name;

  /// The [number] of the unit.
  final int number;

  const Unit({required this.name, required this.number});

  @override
  List<Object> get props => [name, number];
}
