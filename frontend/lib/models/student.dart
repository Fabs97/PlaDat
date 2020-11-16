import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';

class Student extends ChangeNotifier{
  int id;
  String name;
  String surname;
  Map<String, dynamic> skills;

  Student(
      {this.id,
      this.name,
      this.surname,
      this.skills});


  String toJson() {
    return jsonEncode({
      "id": this.id,
      "name": this.name,
       "surname": this.surname,

      "skills": this.skills.map((key, value) =>
          MapEntry(key, value.map((e) => e.toJsonMap()).toList()))
    });
  }

  static Student fromJson(Map<String, dynamic> json) {
    return Student(
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      skills: Skill.listFromJson(json["skills"])
    );
  }


}