// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

import 'package:classroom_app/features/landing/domain/entities/course.dart';

CourseModel courseFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel extends Courses {
  const CourseModel({
    required List<CourseElement> courses,
  }) : super(courses: courses);

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
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

  CourseElement({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CourseElement.fromJson(Map<String, dynamic> json) => CourseElement(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}
