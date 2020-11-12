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

  @override
  String toString() {
    return "$id:$position:$workingHours:$startPeriod";
  }
}
