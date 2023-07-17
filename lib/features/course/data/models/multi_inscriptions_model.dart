// To parse this JSON data, do
//
//     final multiInscriptionsModel = multiInscriptionsModelFromJson(jsonString);

import 'dart:convert';

MultiInscriptionsModel multiInscriptionsModelFromJson(String str) =>
    MultiInscriptionsModel.fromJson(json.decode(str));

String multiInscriptionsModelToJson(MultiInscriptionsModel data) =>
    json.encode(data.toJson());

class MultiInscriptionsModel {
  List<InscriptionObject> inscriptions;

  MultiInscriptionsModel({
    required this.inscriptions,
  });

  factory MultiInscriptionsModel.fromJson(Map<String, dynamic> json) =>
      MultiInscriptionsModel(
        inscriptions: List<InscriptionObject>.from(
            json["inscriptions"].map((x) => InscriptionObject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "inscriptions": List<dynamic>.from(inscriptions.map((x) => x.toJson())),
      };
}

class InscriptionObject {
  String studentId;
  String courseId;

  InscriptionObject({
    required this.studentId,
    required this.courseId,
  });

  factory InscriptionObject.fromJson(Map<String, dynamic> json) =>
      InscriptionObject(
        studentId: json["studentId"],
        courseId: json["courseId"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "courseId": courseId,
      };
}
