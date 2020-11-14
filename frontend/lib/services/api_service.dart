import 'package:frontend/services/api_services/institutions_api_service.dart';
import 'package:frontend/services/api_services/majors_api_service.dart';
import 'package:frontend/services/api_services/placement_api_service.dart';
import 'package:frontend/services/api_services/students_api_service.dart';

import 'api_services/skills_api_service.dart';

enum ENDPOINTS {
  // add a new endpoint for each new high-level API Service you create
  Student,
  Majors,
  Institutions,
  Placement,
  Skills,
}

class APIInfo {
  // Here will be contained all the information for the correct API calls

  // This endpoint is set at compile time when executing the flutter buil/run command.
  // For more information, refer to chapter 4.4 of the README in the root folder
  static const apiEndpoint = String.fromEnvironment('API_ENDPOINT',
      defaultValue: "http://localhost:3000");
}

class APIService {
  // This is the first layer of the API Service, when adding the second layer of your API call,
  // create a file inside the services/api_services folder and add the route to the ENDPOINTS enum
  static Future<dynamic> route(ENDPOINTS endpoint, String subRoute,
      {dynamic body, dynamic urlArgs}) {
    try {
      switch (endpoint) {
        case ENDPOINTS.Student:
          return StudentsAPIService.route(subRoute, body: body);
        case ENDPOINTS.Majors:
          return MajorsAPIService.route(subRoute);
        case ENDPOINTS.Institutions:
          return InstitutionsAPIService.route(subRoute);
        case ENDPOINTS.Skills:
          return SkillsAPIService.route(subRoute, urlArgs: urlArgs);
        case ENDPOINTS.Placement:
          return PlacementAPIService.route(subRoute,
              body: body, urlArgs: urlArgs);
        default:
          throw APIException();
      }
    } catch (e) {
      print("[Error]::APIService - $e");
      return null;
    }
  }
}

class APIException implements Exception {}
