import 'dart:convert';

import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';

class EducationExperience {
  final int id;
  final Major major;
  final Institution institution;
  final String description;
  final DateTime period;

  EducationExperience(
      {this.id, this.major, this.institution, this.description, this.period});

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "major": this.major.toJsonMap(),
      "institution": this.institution.toJsonMap(),
      "description": this.description,
      "period": this.period.toString(),
    };
  }

  static EducationExperience fromJson(Map<String, dynamic> json) {
    return EducationExperience(
      id: json["id"] as int,
      major: Major.fromJson(json["major"]),
      institution: Institution.fromJson(json["institution"]),
      description: json["description"] as String,
      period: json["period"] != null
          ? DateTime.parse(json["period"])
          : null,
    );
  }
}
