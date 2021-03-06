import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/education_experience.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/models/place.dart';
import 'package:frontend/models/work_experience.dart';

class Student extends ChangeNotifier {
  int id;
  String name;
  String surname;
  String description;
  String phone;
  int userId;
  Map<String, dynamic> skills;
  Place location;
  List<EducationExperience> educations;
  List<WorkExperience> works;

  Student({
    this.id,
    this.name,
    this.surname,
    this.description,
    this.phone,
    this.userId,
    this.skills,
    this.educations,
    this.works,
    this.location,
  });

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "name": this.name,
      "surname": this.surname,
      "description": this.description,
      "phone": this.phone,
      "userId": this.userId,
      "skills": this.skills.map((key, value) =>
          MapEntry(key, value.map((e) => e.toJsonMap()).toList())),
      "location": this.location?.toJsonMap() ?? null,
      "education": this
              .educations
              ?.map((education) => education.toJsonMap())
              ?.toList() ??
          [],
      "work": this.works?.map((work) => work.toJsonMap())?.toList() ?? [],
    };
  }

  static Student fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> _skills;
    if (json["skills"] is List<dynamic>)
      _skills = Skill.listFromJson(json["skills"]);
    else {
      _skills = Skill.listFromJsonMap(json["skills"]);
    }

    return Student(
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      description: json["description"],
      phone: json["phone"],
      location:
          json["location"] != null ? Place.fromJson(json['location']) : null,
      userId: json["userId"] ?? json["user_id"] ?? json["userID"],
      skills: _skills,
      educations: EducationExperience.listFromJson(json["education"]),
      works: WorkExperience.listFromJson(json["work"]),
    );
  }

  static List<Student> listFromJson(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed
        .map((studentsJson) => Student.fromJson(studentsJson))
        .toList()
        .cast<Student>();
  }
}
