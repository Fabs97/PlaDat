import 'dart:convert';

class Place {
  int id;
  String description;
  String country;
  String city;

  Place({this.id, this.description, this.country, this.city});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] as int,
      description: json['description'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
    );
  }

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "description": this.description,
      "country": this.country,
      "city": this.city,
    };
  }

  String toString() {
    return "${this.description ?? this.country + " " + this.city}";
  }
}
