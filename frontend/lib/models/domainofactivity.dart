import 'dart:convert';

class Domainofactivity {
  final int id;
  final String name;

  Domainofactivity({this.id, this.name});

  factory Domainofactivity.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Domainofactivity(
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
