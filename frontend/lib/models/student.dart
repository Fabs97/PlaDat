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
  String email;
  String password;
  String description;
  String phone;
  Map<String, dynamic> skills;
  Place location;
  List<EducationExperience> educations;
  List<WorkExperience> works;

  Student({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.description,
    this.phone,
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
      "email": this.email,
      "password": this.password,
      "description": this.description,
      "phone": this.phone,
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
    return Student(
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      password: json["password"],
      description: json["description"],
      phone: json["phone"],
      location:
          json["location"] != null ? Place.fromJson(json['location']) : null,
      skills: Skill.listFromJson(json["skills"]),
      educations: EducationExperience.listFromJson(json["education"]),
          // ?.map((education) => EducationExperience.fromJson(jsonDecode(education)))
          // ?.toList()
          // ?.cast<EducationExperience>(),
      works: WorkExperience.listFromJson(json["work"]),
          // ?.map((work) => WorkExperience.fromJson(jsonDecode(work)))
          // ?.toList()
          // ?.cast<WorkExperience>(),
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
