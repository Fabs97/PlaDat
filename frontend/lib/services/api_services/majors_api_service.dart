import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/major.dart';
import 'package:frontend/services/api_service.dart';

class MajorsAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute) {
    switch (subRoute) {
      case "/majors":
        return _getMajors(subRoute);
      default:
        throw MajorsAPIException();
    }
  }

  static Future<dynamic> _getMajors(String subRoute) async {
    print(APIInfo.apiEndpoint + subRoute);
    var response = await http.get(APIInfo.apiEndpoint + subRoute);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print(parsed);
      return parsed.map((majorJson) => Major.fromJson(majorJson)).toList();
    }
  }
}

class MajorsAPIException extends APIException {}
