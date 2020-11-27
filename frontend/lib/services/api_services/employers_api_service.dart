import 'package:http/http.dart' as http;
import 'package:frontend/models/placement.dart';
import 'package:frontend/services/api_service.dart';

class EmployersAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/employer/:employerId/placements":
        return _getPlacementByEmployerId(subRoute, urlArgs);
      default:
        throw StudentAPIException();
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
}

class StudentAPIException extends APIException {}
