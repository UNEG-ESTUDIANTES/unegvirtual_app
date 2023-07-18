import 'package:classroom_app/core/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.name,
    required super.description,
    required super.teacherId,
  });

  /// Returns an [CourseModel] from [json].
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      teacherId: json["teacherId"],
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
