import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/skill.dart';

class Student extends ChangeNotifier {
  int id;
  String name;
  String surname;
  String email;
  String password;
  String description;
  String phone;
  Map<String, dynamic> skills;

  Student({this.id, this.name, this.surname, this.email,this.password,this.description,this.phone,this.skills});

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "name": this.name,
      "surname": this.surname,
      "email": this.email,
      "password":this.password,
      "description":this.description,
      "phone":this.phone,
      "skills": this.skills.map((key, value) =>
          MapEntry(key, value.map((e) => e.toJsonMap()).toList()))
    });
  }

  static Student fromJson(Map<String, dynamic> json) {
    return Student(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
        description: json["description"],
        phone:  json["phone"],
        skills: Skill.listFromJson(json["skills"]));
  }
}
