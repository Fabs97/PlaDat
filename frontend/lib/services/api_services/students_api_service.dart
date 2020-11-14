import 'dart:convert';
import 'package:frontend/models/skill.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/student.dart';
import 'package:frontend/services/api_service.dart';

class StudentsAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/student":
        return _postStudent(subRoute, body);
      case "/student/id/skills":
        return _postStudentSkills(subRoute, urlArgs, body);
      default:
        throw StudentAPIException();
    }
  }

  static Future<dynamic> _postStudent(String subRoute, Student student) async {
    var response = await http.post(
      APIInfo.apiEndpoint + subRoute,
      headers: {"Content-Type": "application/json"},
      body: student.toJson(),
    );

    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body)[0]);
    }
  }

  static Future _postStudentSkills(
      String subRoute, int id, dynamic skills) async {
    var response = await http.post(
      APIInfo.apiEndpoint + "/student/$id/profile",
      headers: {"Content-Type": "application/json"},
      body: Skill.mapToJson(skills),
    );

    if (response.statusCode == 200) {
      return response;
    }
  }
}

class StudentAPIException extends APIException {}
