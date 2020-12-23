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
    if (this.startPeriod != null)
      res["startPeriod"] = this.startPeriod.toString();
    if (this.endPeriod != null) res["endPeriod"] = this.endPeriod.toString();
    return res;
  }

  static WorkExperience fromJson(Map<String, dynamic> json) {
    final startPeriod = json["startPeriod"] ?? json["start_period"];
    final endPeriod = json["endPeriod"] ?? json["end_period"];
    return WorkExperience(
      id: json["id"] as int,
      companyName: json["companyName"] as String,
      position: json["position"] as String,
      description: json["description"] as String,
      startPeriod: (startPeriod) != null ? DateTime.parse(startPeriod) : null,
      endPeriod: (endPeriod) != null ? DateTime.parse(endPeriod) : null,
    );
  }

  static List<WorkExperience> listFromJson(List<dynamic> json) {
    if (json == null) return null;
    // final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return json
        .map((experiencesJson) => WorkExperience.fromJson(experiencesJson))
        .toList()
        .cast<WorkExperience>();
  }
}
