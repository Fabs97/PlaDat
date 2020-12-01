import 'dart:convert';

class Message {
  final int id;
  final int addresser;
  final int addressee;
  final String message;

  Message({this.id, this.addresser, this.addressee, this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Message(
      id: json["id"] as int,
      addresser: json["addresser"] as int,
      addressee: json["addressee"] as int,
      message: json["message"] as String,
    );
  }

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "addresser": this.addresser,
      "addressee": this.addressee,
      "message": this.message,
    };
  }
}
