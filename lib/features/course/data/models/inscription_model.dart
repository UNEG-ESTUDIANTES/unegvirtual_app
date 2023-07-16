// To parse this JSON data, do
//
//     final inscriptionModel = inscriptionModelFromJson(jsonString);

import 'dart:convert';

import 'package:classroom_app/features/course/domain/entities/inscription.dart';

InscriptionModel inscriptionModelFromJson(String str) =>
    InscriptionModel.fromJson(json.decode(str));

String inscriptionModelToJson(InscriptionModel data) =>
    json.encode(data.toJson());

class InscriptionModel extends Inscription {
  InscriptionModel({
    required InscriptionElement inscription,
  }) : super(inscription: inscription);

  factory InscriptionModel.fromJson(Map<String, dynamic> json) =>
      InscriptionModel(
        inscription: InscriptionElement.fromJson(json["inscription"]),
      );

  Map<String, dynamic> toJson() => {
        "inscription": inscription.toJson(),
      };
}

class InscriptionElement {
  String studentId;
  String courseId;

  InscriptionElement({
    required this.studentId,
    required this.courseId,
  });

  factory InscriptionElement.fromJson(Map<String, dynamic> json) =>
      InscriptionElement(
        studentId: json["studentId"],
        courseId: json["courseId"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "courseId": courseId,
      };
}
