import 'dart:convert';

class Employer {
  final int id;
  final String name;
  final String urlLogo;
  final String location;

  Employer({this.urlLogo, this.location, this.id, this.name});

  factory Employer.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Employer(
      id: json["id"] as int,
      name: json["name"] as String,
      urlLogo: json["urllogo"] as String,
      location: json["location"] as String,
    );
  }

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "name": this.name,
      "urllogo": this.urlLogo,
      "location": this.location,
    };
  }
}
