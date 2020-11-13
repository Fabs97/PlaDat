import 'dart:convert';

class Institution {
  final int id;
  final String name;
  bool chosen = false;

  Institution({this.id, this.name});

  factory Institution.fromJson(Map<String, dynamic> json) {
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
}
