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
}

class PlacementAPIException extends APIException {}
