import 'dart:convert';
import 'package:frontend/models/domainofactivity.dart';
import 'package:frontend/services/custom_http_service.dart' as http;

import 'package:frontend/services/api_service.dart';

class DomainofactivitiesAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/domainOfActivity":
        return _getDomainofactivities(subRoute);
      default:
        throw DomainofactivitiesAPIException();
    }
  }

  static Future<dynamic> _getDomainofactivities(String subRoute) async {
    var response = await http.get(APIInfo.apiEndpoint + subRoute);
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map((majorJson) => Domainofactivity.fromJson(majorJson))
          .toList();
    } else {
      print(response.body);
    }
  }
}

class DomainofactivitiesAPIException extends APIException {}
