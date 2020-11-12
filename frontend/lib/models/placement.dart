import 'dart:convert';

import 'package:flutter/material.dart';

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

  Placement(
      {this.id,
      this.position,
      this.workingHours,
      this.startPeriod,
      this.endPeriod,
      this.salary,
      this.description,
      this.institution,
      this.major});

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
    });
  }

  static Placement fromJson(Map<String, dynamic> json) {
    return Placement(
      id: json["id"],
      position: json["position"],
      workingHours: json["working_hours"],
      startPeriod: json["start_period"],
      endPeriod: json["end_period"],
      salary: json["salary"],
      description: json["description_role"],
      institution: json["institution"],
      major: json["major"],
    );
  }
}
