import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';
import 'package:frontend/models/skill.dart';

enum EmploymentType { FULLTIME, PARTTIME, INTERNSHIP, CONTRACT }

extension EmploymentTypeExtension on EmploymentType {
  String get string {
    switch (this) {
      case EmploymentType.FULLTIME:
        return "FULL_TIME";
      case EmploymentType.PARTTIME:
        return "PART_TIME";
      case EmploymentType.INTERNSHIP:
        return "INTERNSHIP";
      case EmploymentType.CONTRACT:
        return "CONTRACT";
    }
  }

  String get niceString {
    switch (this) {
      case EmploymentType.FULLTIME:
        return "Full Time";
      case EmploymentType.PARTTIME:
        return "Part Time";
      case EmploymentType.INTERNSHIP:
        return "Internship";
      case EmploymentType.CONTRACT:
        return "Contract";
    }
  }

  static String fromBadToNice(String type) {
    switch (type) {
      case "FULL_TIME":
        return EmploymentType.FULLTIME.niceString;
      case "PART_TIME":
        return EmploymentType.PARTTIME.niceString;
      case "CONTRACT":
        return EmploymentType.CONTRACT.niceString;
      case "INTERNSHIP":
        return EmploymentType.INTERNSHIP.niceString;
      default:
        return "";
    }
  }

  static EmploymentType fromString(String type) {
    switch (type) {
      case "FULL_TIME":
        return EmploymentType.FULLTIME;
      case "PART_TIME":
        return EmploymentType.PARTTIME;
      case "CONTRACT":
        return EmploymentType.CONTRACT;
      case "INTERNSHIP":
        return EmploymentType.INTERNSHIP;
      default:
        return null;
    }
  }
}

class Placement extends ChangeNotifier {
  int id;
  String position;
  EmploymentType employmentType;
  DateTime startPeriod;
  DateTime endPeriod;
  int salary;
  String description;
  List<dynamic> institutions;
  List<dynamic> majors;
  Map<String, dynamic> skills;
  int employerId;
  String employerName;
  String countMatches;

  Placement(
      {this.id,
      this.position,
      this.employmentType,
      this.startPeriod,
      this.endPeriod,
      this.salary,
      this.description,
      this.institutions,
      this.majors,
      this.skills,
      this.employerId,
      this.employerName,
      this.countMatches});

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "position": this.position,
      "employmentType": this.employmentType.string,
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
      "employerId": this.employerId,
      "employerName": this.employerName,
      "countMatches": this.countMatches,
    });
  }

  static Placement fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Placement(
        id: json["id"],
        position: json["position"],
        employmentType: json["employment_type"] != null
            ? EmploymentTypeExtension.fromString(json["employment_type"])
            : null,
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
        employerId: json["employerId"],
        employerName: json["employerName"],
        countMatches: json["count_matches"]);
  }

  static List<Placement> listFromJson(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed
        .map((placementsJason) => Placement.fromJson(placementsJason))
        .toList()
        .cast<Placement>();
  }
}
