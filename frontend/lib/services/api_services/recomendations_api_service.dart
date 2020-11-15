import 'dart:convert';
import 'package:frontend/models/placement.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/api_service.dart';

class RecomendationsAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/recommendation/id/seePlacements":
        return _getStudentRecomendations(subRoute, urlArgs);
      default:
        throw RecomendationsAPIException();
    }
  }

  static Future<dynamic> _getStudentRecomendations(
      String subRoute, int id) async {
    var response = await http
        .get(APIInfo.apiEndpoint + "/recommendation/$id/seePlacements");
    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map((placementJson) => Placement.fromJson(placementJson))
          .toList();
    }
  }
}

class RecomendationsAPIException extends APIException {}
