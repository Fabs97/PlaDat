import 'dart:convert';

class Institution {
  final int id;
  final String name;

  Institution({this.id, this.name});

  factory Institution.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Institution(
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
