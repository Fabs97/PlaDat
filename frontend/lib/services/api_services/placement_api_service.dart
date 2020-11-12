import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/placement.dart';
import 'package:frontend/services/api_service.dart';

class PlacementAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/placement/new-placement":
        return _postPlacement(subRoute, body);
      case "/placement/id/add-skills":
        return _postPlacementAddSkills(subRoute, body, urlArgs);
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
      return Placement.fromJson(jsonDecode(response.body));
    }
  }

  static Future<dynamic> _postPlacementAddSkills(
      String subRoute, String skillsJson, String placementId) async {
    var response = await http.post(
      APIInfo.apiEndpoint + "/placement/$placementId/add-skills",
      headers: {"Content-Type": "application/json"},
      body: skillsJson,
    );

    if (response.statusCode == 200) {
      return true;
    }
  }
}

class PlacementAPIException extends APIException {}
