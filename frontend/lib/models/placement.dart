import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/institution.dart';
import 'package:frontend/models/major.dart';
import 'package:frontend/models/place.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/services/auth_service.dart';

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
  int userId;
  int salary;
  String description;
  List<dynamic> institutions;
  List<dynamic> majors;
  Map<String, dynamic> skills;
  Place location;
  int employerId;
  String employerName;
  String countMatches;
  String status;

  Placement(
      {this.id,
      this.position,
      this.employmentType,
      this.startPeriod,
      this.endPeriod,
      this.userId,
      this.salary,
      this.description,
      this.institutions,
      this.majors,
      this.skills,
      this.location,
      this.employerId,
      this.employerName,
      this.countMatches,
      this.status});

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "position": this.position,
      "employmentType": this.employmentType.string,
      "startPeriod": this.startPeriod.toString(),
      "endPeriod": this.endPeriod.toString(),
      "userId": this.userId,
      "salary": this.salary,
      "descriptionRole": this.description,
      "institutions": this
          .institutions
          .map((institution) => institution.toJsonMap())
          .toList(),
      "majors": this.majors.map((major) => major.toJsonMap()).toList(),
      "skills": this.skills.map((key, value) =>
          MapEntry(key, value.map((e) => e.toJsonMap()).toList())),
      "location": this.location?.toJsonMap() ?? null,
      "employerId": this.employerId ?? AuthService().loggedAccountInfo.id,
      "employerName": this.employerName ?? AuthService().loggedAccountInfo.name,
      "countMatches": this.countMatches,
      "status": this.status
    });
  }

  static Placement fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    Map<String, dynamic> _skills;
    if (json["skills"] is List<dynamic>)
      _skills = Skill.listFromJson(json["skills"]);
    else {
      _skills = Skill.listFromJsonMap(json["skills"]);
    }
    return Placement(
      id: json["id"],
      position: json["position"],
      employmentType:
          json["employment_type"] != null || json["employmentType"] != null
              ? EmploymentTypeExtension.fromString(
                  json["employment_type"] ?? json["employmentType"])
          : null,
      startPeriod: json["start_period"] != null || json["startPeriod"] != null
          ? DateTime.parse(json["start_period"] ?? json["startPeriod"])
          : null,
      endPeriod: json["end_period"] != null || json["endPeriod"] != null
          ? DateTime.parse(json["end_period"] ?? json["endPeriod"])
          : null,
      userId: json["userId"] ?? json["user_id"] ?? json["userID"],
      salary: json["salary"],
      description: json["description_role"] ?? json["descriptionRole"],
      institutions: json["institutions"]
          ?.map((institution) => Institution.fromJson(institution))
          ?.toList(),
      majors: json["majors"]?.map((major) => Major.fromJson(major))?.toList(),
      skills: _skills,
      employerId: json["employer_id"] ?? json["employerId"],
      employerName: json["employer_name"] ?? json["employerName"],
      countMatches: json["count_matches"] ?? json["countMatches"],
      location:
          json["location"] != null ? Place.fromJson(json['location']) : null,
      status: json["status"],
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
