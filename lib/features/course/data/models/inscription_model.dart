import 'package:classroom_app/features/course/domain/entities/inscription.dart';

class InscriptionModel extends Inscription {
  const InscriptionModel({required super.courseId, required super.studentId});

  /// Returns an [InscriptionModel] from [json].
  factory InscriptionModel.fromJson(Map<String, dynamic> json) {
    return InscriptionModel(
      courseId: json['courseId'],
      studentId: json['studentId'],
    );
  }

  /// Returns an [InscriptionModel] from the [inscription].
  factory InscriptionModel.fromEntity(Inscription inscription) {
    return InscriptionModel(
      courseId: inscription.courseId,
      studentId: inscription.studentId,
    );
  }

  /// Converts the [InscriptionModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'courseId': courseId,
    };
  }
}
