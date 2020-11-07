import 'package:flutter/material.dart';

class Placement {
  final String id;
  final String role;
  final int hours;
  final DateTimeRange period;
  final int salary;
  final String description;
  // final String institutions;
  // final String majors;

  // TODO: required fields must be chosen
  Placement(
    this.role,
    this.hours,
    this.period,
    this.salary, {
    this.id,
    this.description,
  });
}
