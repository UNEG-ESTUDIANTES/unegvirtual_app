import 'package:unegvirtual_app/features/course/domain/entities/new_course.dart';

class NewCourseModel extends NewCourse {
  const NewCourseModel({
    required super.name,
    required super.description,
    required super.teacherId,
  });

  /// Returns an [NewCourseModel] from the [newCourse].
  factory NewCourseModel.fromEntity(NewCourse newCourse) {
    return NewCourseModel(
      description: newCourse.description,
      name: newCourse.name,
      teacherId: newCourse.teacherId,
    );
  }

  /// Converts the [NewCourseModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'teacherId': teacherId,
    };
  }
}
