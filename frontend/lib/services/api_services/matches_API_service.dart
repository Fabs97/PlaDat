import 'dart:convert';
import 'package:frontend/models/match.dart';
import 'package:frontend/services/custom_http_service.dart' as http;
import 'package:frontend/services/api_service.dart';

class MatchesAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/matching":
        return _postMatch(subRoute, body);
      case "/match/:studentId/:placementId":
        return _deleteMatch(subRoute, urlArgs);
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
      return Match.fromJson(jsonDecode(response.body)[0]);
    } else {
      print(response.body);
    }
  }

  static Future<dynamic> _deleteMatch(String subRoute, Match args) async {
    var response = await http.delete(
        APIInfo.apiEndpoint + "/match/${args.studentID}/${args.placementID}");
    switch (response.statusCode) {
      case 200:
        {
          return true;
        }
      default:
        return response.body;
    }
  }
}

class MatchesAPIException extends APIException {}
