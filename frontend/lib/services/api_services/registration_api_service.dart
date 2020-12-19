import 'dart:convert';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/custom_http_service.dart' as http;
import 'package:frontend/services/api_service.dart';

class RegistrationAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/registration":
        return _postUserRegistration(subRoute, body);
      default:
        throw RegistrationAPIServiceException();
    }
  }

  static Future<dynamic> _postUserRegistration(
      String subRoute, User user) async {
    var response = await http.post(
      APIInfo.apiEndpoint + "/registration",
      headers: {"Content-Type": "application/json"},
      body: user.toJson(),
      needsAuth: false,
    );
    int statusCode = response.statusCode;
    switch (statusCode) {
      case 200:
        return User.fromJson(
            jsonDecode(response.body));
      case 409:
        return "The user with the given email is already present in the database";
      case 500:
        return "Something went wrong while trying to connect to the database";
      default:
        throw RegistrationAPIServiceException();
    }
  }
}

class RegistrationAPIServiceException extends APIException {}
