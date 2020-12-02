import 'dart:convert';

enum Sender { STUDENT, EMPLOYER }

extension SenderExtension on Sender {
  String get string {
    switch (this) {
      case Sender.EMPLOYER:
        return "EMPLOYER";
      case Sender.STUDENT:
        return "STUDENT";
    }
  }

  static Sender getFrom(String stringType) {
    switch (stringType) {
      case "STUDENT":
        return Sender.STUDENT;
      case "EMPLOYER":
        return Sender.EMPLOYER;
      default:
        return null;
    }
  }
}

class Message {
  final int id;
  final int studentId;
  final int employerId;
  final String message;
  final DateTime sendDate;
  final Sender sender;

  Message(
      {this.sender,
      this.id,
      this.studentId,
      this.employerId,
      this.message,
      this.sendDate});

  factory Message.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Message(
      id: json["id"] as int,
      studentId: json["student_id"] as int,
      employerId: json["employer_id"] as int,
      message: json["message"] as String,
      sendDate: json["send_date"] != null
          ? DateTime.parse(json["send_date"])
          : null,
      sender: SenderExtension.getFrom(json["sender"]),
    );
  }

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "studentId": this.studentId,
      "employerId": this.employerId,
      "message": this.message,
      "sendDate": this.sendDate.toString(),
      "sender": this.sender.string,
    };
  }
}
