import 'dart:convert';
import 'package:frontend/models/degree.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/api_service.dart';

class DegreeAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/degrees":
        return _getDegrees(subRoute);
      default:
        throw DegreeAPIException();
    }
  }

  static Future<dynamic> _getDegrees(String subRoute) async {
    var response = await http.get(APIInfo.apiEndpoint + subRoute);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map((degreesJson) => Degree.fromJson(degreesJson)).toList();
    }
  }
}

class DegreeAPIException extends APIException {}
