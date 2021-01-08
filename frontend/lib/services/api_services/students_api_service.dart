import 'dart:convert';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/skill.dart';
import 'package:frontend/services/custom_http_service.dart' as http;
import 'package:frontend/models/student.dart';
import 'package:frontend/services/api_service.dart';

class StudentsAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/student":
        return _postStudent(subRoute, body);
      case "/student/:id":
        return _getStudentById(urlArgs);
      case "/student/id/skills":
        return _postStudentSkills(subRoute, urlArgs, body);
      case "/student/{studentId}/placements":
        return _getMatchedPlacementsByStudentId(subRoute, urlArgs);
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
    switch (response.statusCode) {
      case 200:
        {
          return Student.fromJson(jsonDecode(response.body));
        }
      default:
        return response.body;
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
    } else {
      print(response.body);
    }
  }

  static Future<dynamic> _getStudentById(int id) async {
    var response = await http.get(APIInfo.apiEndpoint + "/student/$id");
    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
    }
  }

  static Future<dynamic> _getMatchedPlacementsByStudentId(
      String subRoute, int id) async {
    var response =
        await http.get(APIInfo.apiEndpoint + "/student/$id/placements");
    switch (response.statusCode) {
      case 200:
        {
          return Placement.listFromJson(response.body);
        }
      default:
        return response.body;
    }
  }
}

class StudentAPIException extends APIException {}
