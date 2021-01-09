import 'package:frontend/models/user.dart';
import 'dart:html' show window;
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/api_services/login_api_service.dart';

class AuthException implements Exception {}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User _loggedUser;
  dynamic _loggedAccountInfo;
  String _jwtToken;

  String get jwtToken {
    if (this._jwtToken == null) {
      this._jwtToken = window.localStorage.containsKey("jwtToken")
          ? window.localStorage["jwtToken"]
          : throw AuthException();
    }
    return this._jwtToken;
  }

  User get loggedUser => _loggedUser;

  dynamic get loggedAccountInfo => this._loggedAccountInfo;

  void setLoggedAccountInfo(AccountType accountType, int id) async {
    this._loggedAccountInfo = await (accountType == AccountType.Student
        ? APIService.route(
            ENDPOINTS.Student,
            "/student/:id",
            urlArgs: id,
          )
        : APIService.route(
            ENDPOINTS.Employers,
            "/employer/:id",
            urlArgs: id,
          ));
  }

  dynamic login(User user) async {
    try {
      final response = await APIService.route(
        ENDPOINTS.Login,
        "/login",
        body: user,
      );
      if (response is Map<String, dynamic>) {
        final studentId = response["studentID"];
        final employerId = response["employerID"];

        if (studentId != null)
          user.type = AccountType.Student;
        else if (employerId != null)
          user.type = AccountType.Employer;
        else
          user.type =
              response["student"] ? AccountType.Student : AccountType.Employer;

        user.id = response["userID"];

        this._loggedUser = user;
        window.localStorage["jwtToken"] = response["token"];
        this._jwtToken = response["token"];
        if (studentId != null) {
          this._loggedAccountInfo = await APIService.route(
            ENDPOINTS.Student,
            "/student/:id",
            urlArgs: studentId,
          );
        } else if (employerId != null) {
          this._loggedAccountInfo = await APIService.route(
            ENDPOINTS.Employers,
            "/employer/:id",
            urlArgs: employerId,
          );
        } else if (employerId == null && studentId == null) {
          return response["student"];
        }
        return this._loggedAccountInfo;
      }
    } on LoginAPIException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}
