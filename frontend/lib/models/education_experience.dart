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
      "major": this.major.name,
      "degreeId": this.degree.id,
      "degree": this.degree.name,
      "institutionId": this.institution.id,
      "institution": this.institution.name,
      "description": this.description,
      "startPeriod": this.startPeriod.toString(),
      "endPeriod": this.endPeriod.toString(),
    };
  }

  static EducationExperience fromJson(Map<String, dynamic> json) {
    final startPeriod = json["startPeriod"] ?? json["start_period"];
    final endPeriod = json["endPeriod"] ?? json["end_period"];
    return EducationExperience(
      id: json["id"] as int,
      major: Major(name: json["major"]),
      institution: Institution(name: json["institution"]),
      degree: Degree(name: json["degree"]),
      description: json["description"] as String,
      startPeriod: (startPeriod) != null ? DateTime.parse(startPeriod) : null,
      endPeriod: (endPeriod) != null ? DateTime.parse(endPeriod) : null,
    );
  }

  static List<EducationExperience> listFromJson(List<dynamic> json) {
    if (json == null) return null;
    return json
        .map((experiencesJson) => EducationExperience.fromJson(experiencesJson))
        .toList()
        .cast<EducationExperience>();
  }
}
