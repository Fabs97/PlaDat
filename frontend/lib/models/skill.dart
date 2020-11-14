import 'dart:convert';

class Skill {
  final int id;
  final String name;
  final String type;

  Skill({this.id, this.name, this.type});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json["id"] as int,
      name: json["name"] as String,
      type: json["type"] as String,
    );
  }

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "name": this.name,
      "type": this.type,
    });
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "name": this.name,
      "type": this.type,
    };
  }

  static String mapToJson(Map<String, dynamic> skillsList) {
    return jsonEncode(skillsList.map((key, value) =>
        MapEntry(key, value.map((e) => e.toJsonMap()).toList())));
  }

  static List<Skill> listFromJson(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed.map((skillsJson) => Skill.fromJson(skillsJson)).toList();
  }
}
