import 'dart:convert';
import 'package:frontend/models/match.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/api_service.dart';

class MatchesAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute, {dynamic body}) {
    switch (subRoute) {
      case "/matching":
        return _postMatch(subRoute, body);
      default:
        throw MatchesAPIException();
    }
  }

  static Future<dynamic> _postMatch(String subRoute, Match match) async {
    var response = await http.post(
      APIInfo.apiEndpoint + subRoute,
      headers: {"Content-Type": "application/json"},
      body: match.toJson(),
    );
    if (response.statusCode == 200) {
      return Match.fromJson(jsonDecode(response.body));
    }
  }
}

class MatchesAPIException extends APIException {}
