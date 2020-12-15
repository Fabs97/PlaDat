import 'dart:convert';

import 'package:frontend/models/place.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/api_service.dart';

class LocationsAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/googleMaps":
        return fetchPlaces(subRoute, urlArgs);
      default:
        throw LocationAPIException();
    }
  }

  static Future<List<Place>> fetchPlaces(String subRoute, String input) async {
    final response = await http.get(
      APIInfo.apiEndpoint + subRoute + "/$input",
    );

    if (response.statusCode == 200) {
      var preObjsJson = jsonDecode(utf8.decode(response.bodyBytes))['predictions'] as List;
      List<Place> tagObjs =
          preObjsJson.map((tagJson) => Place.fromJson(tagJson)).toList();
      return tagObjs;
    }
  }
}

class LocationAPIException extends APIException {}
