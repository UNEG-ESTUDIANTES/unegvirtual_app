import 'package:classroom_app/features/landing/domain/entities/course.dart';
import 'package:classroom_app/features/landing/domain/usecases/get_courses.dart';
import 'package:flutter/material.dart';

import '../../../../core/usecases/usecases.dart';

class LandingNotifier extends ChangeNotifier {
  final GetCourses _getCourses;

  LandingNotifier({
    required GetCourses getCourses,
  }) : _getCourses = getCourses;

  bool? isLoading = true;
  Courses? courses;
  String? error;

  Future<void> getCoursesList() async {
    // show loading
    isLoading = true;

    error = '';

    final result = await _getCourses(NoParams());
    print(result);

    // Handle success or error
    result.fold(
      (e) {
        error = "fail";
        isLoading = false;
      },
      (c) {
        courses = c;
        isLoading = false;
      },
    );

    // notify UI
    notifyListeners();
  }
}
