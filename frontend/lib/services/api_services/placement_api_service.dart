import 'dart:convert';
import 'package:frontend/services/custom_http_service.dart' as http;
import 'package:frontend/models/student.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/services/api_service.dart';

class PlacementAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/placement/new-placement":
        return _postPlacement(subRoute, body);
      case "placements":
        return _getPlacements(subRoute);
      case "/placement/:placementId/students":
        return _getMatchedStudentsByPlacementId(subRoute, urlArgs);
      default:
        throw PlacementAPIException();
    }
  }

  static Future<dynamic> _postPlacement(
      String subRoute, Placement placement) async {
    var response = await http.post(
      APIInfo.apiEndpoint + subRoute,
      headers: {"Content-Type": "application/json"},
      body: placement.toJson(),
    );

    if (response.statusCode == 200) {
      final placement = Placement.fromJson(jsonDecode(response.body));
      return placement;
    }
  }

  static Future<dynamic> _getPlacements(String subRoute) async {
    var response = await http.get(APIInfo.apiEndpoint + subRoute);

    if (response.statusCode == 200) {
      return Placement.listFromJson(response.body);
    }
  }

  static Future<dynamic> _getMatchedStudentsByPlacementId(
      String subRoute, int id) async {
    var response =
        await http.get(APIInfo.apiEndpoint + "/placement/$id/students");
    switch (response.statusCode) {
      case 200:
        {
          return Student.listFromJson(response.body);
        }
      default:
        return response.body;
    }
  }
}

class PlacementAPIException extends APIException {}
