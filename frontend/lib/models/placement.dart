import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';

class Placement extends ChangeNotifier {
  int id;
  String position;
  int workingHours;
  DateTime startPeriod;
  DateTime endPeriod;
  int salary;
  String description;
  String institution;
  String major;
  Map<String, dynamic> skills;

  Placement(
      {this.id,
      this.position,
      this.workingHours,
      this.startPeriod,
      this.endPeriod,
      this.salary,
      this.description,
      this.institution,
      this.major,
      this.skills});

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "position": this.position,
      "workingHours": this.workingHours,
      "startPeriod": this.startPeriod.toString(),
      "endPeriod": this.endPeriod.toString(),
      "salary": this.salary,
      "descriptionRole": this.description,
      "institution": this.institution,
      "major": this.major,
      "skills": this.skills.map(
          (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList()))
    });
  }

  static Placement fromJson(Map<String, dynamic> json) {
    // final techSkills =
    //     json["skills"]["technicalSkills"].map((skill) => skill.fromJson(skill));
    // final softSkills =
    //     json["skills"]["softSkills"].map((skill) => skill.fromJson(skill));
    // final otherSkills =
    //     json["skills"]["otherSkills"].map((skill) => skill.fromJson(skill));

    return Placement(
      id: json["id"],
      position: json["position"],
      workingHours: json["working_hours"],
      startPeriod: DateTime.parse(json["start_period"]),
      endPeriod: DateTime.parse(json["end_period"]),
      salary: json["salary"],
      description: json["description_role"],
      institution: json["institution"],
      major: json["major"],
      skills: json["skills"].forEach((key, value) =>
          MapEntry(key, value.map((skill) => skill.fromJson()))),
    );
  }
}
