import 'dart:convert';

class WorkExperience {
  int id;
  String companyName;
  String position;
  String description;
  DateTime startPeriod;
  DateTime endPeriod;

  WorkExperience({
    this.id,
    this.companyName,
    this.position,
    this.description,
    this.startPeriod,
    this.endPeriod,
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
      "startPeriod": this.startPeriod.toString(),
      "endPeriod": this.endPeriod.toString(),
    };
  }

  static WorkExperience fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      id: json["id"] as int,
      companyName: json["companyName"] as String,
      position: json["position"] as String,
      description: json["description"] as String,
      startPeriod: json["startPeriod"] != null
          ? DateTime.parse(json["startPeriod"])
          : null,
      endPeriod:
          json["endPeriod"] != null ? DateTime.parse(json["endPeriod"]) : null,
    );
  }

  static List<WorkExperience> listFromJson(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed
        .map((experiencesJson) => WorkExperience.fromJson(experiencesJson))
        .toList()
        .cast<WorkExperience>();
  }
}
