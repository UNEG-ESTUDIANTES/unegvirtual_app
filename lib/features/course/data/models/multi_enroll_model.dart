import 'package:unegvirtual_app/features/course/domain/entities/multi_enroll.dart';

class MultiEnrollModel extends MultiEnroll {
  const MultiEnrollModel({required super.courseId, required super.studentIds});

  /// Returns an [MultiEnrollModel] from the [multiEnroll].
  factory MultiEnrollModel.fromEntity(MultiEnroll multiEnroll) {
    return MultiEnrollModel(
      courseId: multiEnroll.courseId,
      studentIds: multiEnroll.studentIds,
    );
  }

  /// Converts the [MultiEnrollModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'studentIds': studentIds,
      'courseId': courseId,
    };
  }
}
