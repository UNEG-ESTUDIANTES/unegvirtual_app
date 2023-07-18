import 'package:classroom_app/core/entities/courses.dart';
import 'package:classroom_app/core/models/course_model.dart';

class CoursesModel extends Courses {
  const CoursesModel({required super.courses});

  /// Returns a [CoursesModel] from [json].
  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonCourses = json['courses'];

    return CoursesModel(
      courses: List.from(
        jsonCourses.map((json) => CourseModel.fromJson(json)),
      ),
    );
  }

  /// Converts the [CoursesModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      "courses": List.from(courses.map((course) => course.toJson())),
    };
  }

  @override
  List<CourseModel> get courses {
    return List.from(
      super.courses.map((course) => CourseModel.fromEntity(course)),
    );
  }
}
