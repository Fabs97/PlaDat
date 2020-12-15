import 'dart:convert';

enum AccountType { Student, Employer }

extension AccountTypeExtension on AccountType {
  String get string {
    switch (this) {
      case AccountType.Student:
        return "STUDENT";
      case AccountType.Employer:
        return "EMPLOYER";
      default:
        return "";
    }
  }

  static AccountType getTypeFrom(String string) {
    switch (string) {
      case "STUDENT":
        return AccountType.Student;
      case "EMPLOYER":
        return AccountType.Employer;
      default:
        return null;
    }
  }
}

class User {
  final int id;
  final String email;
  final String password;
  final AccountType type;

  User({this.id, this.email, this.password, this.type});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as int,
      email: json["email"] as String,
      password: json["password"] as String,
      type: AccountTypeExtension.getTypeFrom(json["type"] as String),
    );
  }

  String toJson() {
    return jsonEncode(this.toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "id": this.id,
      "email": this.email,
      "password": this.password,
      "type": this.type.string,
    };
  }
}
