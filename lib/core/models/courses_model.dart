import 'package:classroom_app/core/entities/courses.dart';

class CoursesModel extends Courses {
  CoursesModel({
    required List<CourseElement> courses,
  }) : super(courses: courses);

  factory CoursesModel.fromJson(Map<String, dynamic> json) => CoursesModel(
        courses: List<CourseElement>.from(
            json["courses"].map((x) => CourseElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
      };
}

class CourseElement {
  String id;
  String name;
  String description;
  String teacherId;

  CourseElement({
    required this.id,
    required this.name,
    required this.description,
    required this.teacherId,
  });

  factory CourseElement.fromJson(Map<String, dynamic> json) => CourseElement(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        teacherId: json["teacherId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "teacherId": teacherId,
      };
}
