import 'dart:convert';
import 'package:frontend/services/custom_http_service.dart' as http;
import 'package:frontend/models/institution.dart';
import 'package:frontend/services/api_service.dart';

class InstitutionsAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute) {
    switch (subRoute) {
      case "/institutions":
        return _getInstitutions(subRoute);
      default:
        throw InstitutionsAPIException();
    }
  }

  static Future<dynamic> _getInstitutions(String subRoute) async {
    var response = await http.get(APIInfo.apiEndpoint + subRoute);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map((institutionJson) => Institution.fromJson(institutionJson))
          .toList();
    }
  }
}

class InstitutionsAPIException extends APIException {}
