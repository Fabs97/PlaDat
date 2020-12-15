import 'dart:convert';

class Degree {
  final int id;
  final String name;

  Degree({this.id, this.name});

  factory Degree.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Degree(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "name": this.name,
    });
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "name": this.name,
    };
  }
}
