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
    Map<String, dynamic> res = {};
    if (this.id != null) res["id"] = this.id;
    if (this.companyName != null) res["companyName"] = this.companyName;
    if (this.position != null) res["position"] = this.position;
    if (this.description != null) res["description"] = this.description;
    if (this.startPeriod != null) res["startPeriod"] = this.startPeriod.toString();
    if (this.endPeriod != null) res["endPeriod"] = this.endPeriod.toString();
    return res;
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
