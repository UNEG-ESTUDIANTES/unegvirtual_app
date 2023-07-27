import 'package:flutter/material.dart';

import 'package:unegvirtual_app/core/entities/user.dart';

class StudentsEnrollmentProvider extends ChangeNotifier {
  final List<User> selectedStudents = [];

  /// If the list can be submitted.
  bool get isSubmittable => selectedStudents.isNotEmpty;

  /// Removes or add the [user] from selected.
  void toggleStudent(User user) {
    if (selectedStudents.contains(user)) {
      selectedStudents.remove(user);
    } else {
      selectedStudents.add(user);
    }

    notifyListeners();
  }

  /// Resets the selected list.
  void reset() {
    selectedStudents.clear();
    notifyListeners();
  }
}
