import 'package:flutter/material.dart';

import 'package:classroom_app/features/landing/domain/entities/course.dart';
import 'package:classroom_app/features/landing/domain/usecases/get_courses.dart';

import '../../../../core/use_cases/use_case.dart';

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
