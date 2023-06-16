import 'dart:convert';

List<Course> scoresModelFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

class Course {
  const Course({required this.name, required this.sumary});
  final String name;
  final String sumary;

  factory Course.fromJson(Map<String, dynamic> json) =>
      Course(name: json["name"], sumary: json["sumary"]);
}
