import 'dart:convert';

import 'package:frontend/models/employer.dart';
import 'package:frontend/services/custom_http_service.dart' as http;
import 'package:frontend/models/placement.dart';
import 'package:frontend/services/api_service.dart';

class EmployersAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
       case "/employer":
        return _postEmployer(subRoute, body);
      case "/employer/:employerId/placements":
        return _getPlacementByEmployerId(subRoute, urlArgs);
      case "/employer/:id":
        return _getEmployerById(urlArgs.toString());
      default:
        throw EmployerAPIException();
    }
  }

  static Future<dynamic> _getPlacementByEmployerId(
      String subRoute, int id) async {
    var response =
        await http.get(APIInfo.apiEndpoint + "/employer/$id/placements");
    if (response.statusCode == 200) {
      return Placement.listFromJson(response.body);
    }
  }

  static Future<dynamic> _getEmployerById(String id) async {
    var response = await http.get(APIInfo.apiEndpoint + "/employer/$id");
    if (response.statusCode == 200) {
      return Employer.fromJson(jsonDecode(response.body));
    }
  }
static  Future<dynamic> _postEmployer(String subRoute, Employer employer) async {
    var response = await http.post(
      APIInfo.apiEndpoint + subRoute,
      headers: {"Content-Type": "application/json"},
      body: employer.toJson(),
    );
    switch (response.statusCode) {
      case 200:
        {
          return Employer.fromJson(jsonDecode(response.body));
        }
      default:
        return response.body;
    }
  }
}



class EmployerAPIException extends APIException {}
