import 'dart:convert';

import 'package:frontend/models/degree.dart';
import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';

class EducationExperience {
  int id;
  Major major;
  Institution institution;
  Degree degree;
  String description;
  DateTime startPeriod;
  DateTime endPeriod;

  EducationExperience({
    this.id,
    this.major,
    this.institution,
    this.degree,
    this.description,
    this.startPeriod,
    this.endPeriod,
  });

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "majorId": this.major.id,
      "degreeId": this.degree.id,
      "institutionId": this.institution.id,
      "description": this.description,
      "startPeriod": this.startPeriod.toString(),
      "endPeriod": this.endPeriod.toString(),
    };
  }

  static EducationExperience fromJson(Map<String, dynamic> json) {
    return EducationExperience(
      id: json["id"] as int,
      major: Major.fromJson(json["major"]),
      institution: Institution.fromJson(json["institution"]),
      degree: Degree.fromJson(json["degree"]),
      description: json["description"] as String,
      startPeriod: json["startPeriod"] != null
          ? DateTime.parse(json["startPeriod"])
          : null,
      endPeriod:
          json["endPeriod"] != null ? DateTime.parse(json["endPeriod"]) : null,
    );
  }

  static List<EducationExperience> listFromJson(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed
        .map((experiencesJson) => EducationExperience.fromJson(experiencesJson))
        .toList()
        .cast<EducationExperience>();
  }
}
