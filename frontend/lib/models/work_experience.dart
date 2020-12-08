import 'dart:convert';

class WorkExperience {
  final int id;
  final String companyName;
  final String position;
  final String description;
  final DateTime workPeriod;

  WorkExperience({
    this.id,
    this.companyName,
    this.position,
    this.description,
    this.workPeriod,
  });

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "companyName": this.companyName,
      "position": this.position,
      "description": this.description,
      "workPeriod": this.workPeriod.toString(),
    };
  }

  static WorkExperience fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      id: json["id"] as int,
      companyName: json["companyName"] as String,
      position: json["position"] as String,
      description: json["description"] as String,
      workPeriod: json["workPeriod"] != null
          ? DateTime.parse(json["workPeriod"])
          : null,
    );
  }
}
