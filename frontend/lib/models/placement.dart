import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';
import 'package:frontend/models/skill.dart';

class Placement extends ChangeNotifier {
  int id;
  String position;
  int workingHours;
  DateTime startPeriod;
  DateTime endPeriod;
  int salary;
  String description;
  List<dynamic> institutions;
  List<dynamic> majors;
  Map<String, dynamic> skills;
  int employerId;

  Placement(
      {this.id,
      this.position,
      this.workingHours,
      this.startPeriod,
      this.endPeriod,
      this.salary,
      this.description,
      this.institutions,
      this.majors,
      this.skills,
      this.employerId});

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "position": this.position,
      "workingHours": this.workingHours,
      "startPeriod": this.startPeriod.toString(),
      "endPeriod": this.endPeriod.toString(),
      "salary": this.salary,
      "descriptionRole": this.description,
      "institutions": this
          .institutions
          .map((institution) => institution.toJsonMap())
          .toList(),
      "majors": this.majors.map((major) => major.toJsonMap()).toList(),
      "skills": this.skills.map((key, value) =>
          MapEntry(key, value.map((e) => e.toJsonMap()).toList())),
      "employerId" : this.employerId,
    });
  }

  static Placement fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Placement(
      id: json["id"],
      position: json["position"],
      workingHours: json["working_hours"],
      startPeriod: json["start_period"] != null
          ? DateTime.parse(json["start_period"])
          : null,
      endPeriod: json["end_period"] != null
          ? DateTime.parse(json["end_period"])
          : null,
      salary: json["salary"],
      description: json["description_role"],
      institutions: json["institutions"]
          ?.map((institution) => Institution.fromJson(institution))
          ?.toList(),
      majors: json["majors"]?.map((major) => Major.fromJson(major))?.toList(),
      skills: Skill.listFromJson(json["skills"]),
      employerId: json["employer_id"],
    );
  }

  static List<Placement> listFromJson(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed
        .map((placementsJason) => Placement.fromJson(placementsJason))
        .toList()
        .cast<Placement>();
  }
}
