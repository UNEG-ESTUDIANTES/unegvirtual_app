import 'package:classroom_app/core/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.name,
    required super.description,
    required super.teacherId,
  });

  /// Returns a [CourseModel] from [json].
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      teacherId: json["teacherId"],
    );
  }

  /// Returns an [CourseModel] from the [course].
  factory CourseModel.fromEntity(Course course) {
    return CourseModel(
      id: course.id,
      name: course.name,
      description: course.description,
      teacherId: course.teacherId,
    );
  }

  /// Converts the [CourseModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "description": description,
      "teacherId": teacherId,
    };
  }
}
