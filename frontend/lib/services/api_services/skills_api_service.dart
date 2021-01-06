import 'dart:convert';
import 'package:frontend/services/custom_http_service.dart' as http;
import 'package:frontend/models/skill.dart';
import 'package:frontend/services/api_service.dart';

class SkillsAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/skills/type":
        return _getSkillsByType(subRoute, urlArgs);
      default:
        throw SkillsAPIException();
    }
  }

  static Future<dynamic> _getSkillsByType(String subRoute, String type) async {
    var response = await http.get(APIInfo.apiEndpoint + "/skills/$type");
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map((skillsJson) => Skill.fromJson(skillsJson)).toList();
    } else {
      print(response.body);
    }
  }
}

class SkillsAPIException extends APIException {}
