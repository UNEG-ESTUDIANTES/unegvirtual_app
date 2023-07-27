import 'package:equatable/equatable.dart';

import 'package:unegvirtual_app/core/entities/course.dart';

class Courses extends Equatable {
  final List<Course> courses;

  const Courses({required this.courses});

  @override
  List<Object> get props => [courses];
}
