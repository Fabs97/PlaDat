import 'dart:convert';
import 'package:frontend/models/message.dart';
import 'package:frontend/screens/chat_screen/chat_screen.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/api_service.dart';

class MessagesAPIService extends APIInfo {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/message/:studentId/:employerId":
        return _getMessages(subRoute, urlArgs);
      case "/message":
        return _postMessage(subRoute, body);
      default:
        throw MessagesAPIException();
    }
  }

  static Future<dynamic> _getMessages(
      String subRoute, ChatScreenArguments args) async {
    var response = await http.get(
        APIInfo.apiEndpoint + "/message/${args.studentId}/${args.employerId}");
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map((messageJson) => Message.fromJson(messageJson))
          .toList();
    }
  }

  static Future<dynamic> _postMessage(String subRoute, Message message) async {
    var response = await http.post(
      APIInfo.apiEndpoint + subRoute,
      headers: {"Content-Type": "application/json"},
      body: message.toJson(),
    );
    if (response.statusCode == 200) {
      return Message.fromJson(jsonDecode(response.body));
    }
  }
}

class MessagesAPIException extends APIException {}
