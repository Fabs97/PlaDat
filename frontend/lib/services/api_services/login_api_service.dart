import 'dart:convert';

import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/custom_http_service.dart' as http;

class LoginAPIService {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/login":
        return _login(subRoute, body);
      default:
        throw LoginAPIException();
    }
  }

  static Future<dynamic> _login(String subRoute, dynamic user) async {
    final response = await http.post(
      APIInfo.apiEndpoint + subRoute,
      needsAuth: false,
      headers: {"Content-Type": "application/json"},
      body: user.toJson(),
    );
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body) as Map<String, dynamic>;
      default:
        throw LoginAPIException(message: response.body);
    }
  }
}

class LoginAPIException extends APIException {
  final String message;

  LoginAPIException({this.message});
}
