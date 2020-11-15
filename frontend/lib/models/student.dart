import 'dart:convert';

import 'package:flutter/material.dart';

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

      // ! This is throwing the following exception: 
      // ! Expected a value of type 'Map<String, dynamic>', but got one of type 'MappedListIterable<dynamic, dynamic>'
      // ! Fix this when needed
      // skills: json["skills"].map((entry) {
      //   entry.value = entry.value.map((skill) => Skill.fromJson(skill)).toList();
      // }),
    );
  }


}