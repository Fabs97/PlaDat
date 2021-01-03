import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/place.dart';

class Employer extends ChangeNotifier {
  int id;
  String name;
  Place location;
  String domainOfActivityId;
  String description;
  
  
  

  Employer({this.id, this.name, this.location, this.domainOfActivityId,this.description});

  factory Employer.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Employer(
      id: json["id"] as int,
      name: json["name"] as String,
      location: 
          json["location"] != null ? Place.fromJson(json['location']) : null,
      domainOfActivityId: json["domainOfActivityId"],    
      description: json["description"] as String,
    );
  }

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "name": this.name,
      "location": this.location?.toJsonMap() ?? null,
      "domainOfActivityId": this.domainOfActivityId,
      "description": this.description,
    };
  }
}
