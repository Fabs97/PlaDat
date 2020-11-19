import 'dart:convert';

class Major {
  final int id;
  final String name;

  Major({this.id, this.name});

  factory Major.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Major(
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
