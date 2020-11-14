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
}
