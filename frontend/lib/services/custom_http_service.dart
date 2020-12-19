import 'dart:async';
import 'dart:convert';

import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> get(String route,
    {Map<String, String> headers, bool needsAuth = true}) async {
  try {
    if (needsAuth) headers["Bearer-Token"] = AuthService().jwtToken;
    return await http.get(
      route,
      headers: headers,
    );
  } on AuthException catch (e) {
    Nav.navigatorKey.currentState.pushNamed("/login", arguments: true);
    return null;
  }
}

Future<Response> post(String route,
    {Map<String, String> headers,
    body,
    Encoding encoding,
    bool needsAuth = true}) async {
  try {
    if (needsAuth) headers["Bearer-Token"] = AuthService().jwtToken;
    return await http.post(
      route,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  } on AuthException catch (e) {
    Nav.navigatorKey.currentState.pushNamed("/login", arguments: true);
    return null;
  }
}

Future<Response> put(String route,
    {Map<String, String> headers,
    body,
    Encoding encoding,
    bool needsAuth = true}) async {
  try {
    if (needsAuth) headers["Bearer-Token"] = AuthService().jwtToken;
    return await http.put(
      route,
      headers: headers,
      encoding: encoding,
    );
  } on AuthException catch (e) {
    Nav.navigatorKey.currentState.pushNamed("/login", arguments: true);
    return null;
  }
}

Future<Response> delete(String route,
    {Map<String, String> headers, bool needsAuth = true}) async {
  try {
    if (needsAuth) headers["Bearer-Token"] = AuthService().jwtToken;
    return await http.delete(
      route,
      headers: headers,
    );
  } on AuthException catch (e) {
    Nav.navigatorKey.currentState.pushNamed("/login", arguments: true);
    return null;
  }
}
